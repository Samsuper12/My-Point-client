function getDatabase() {
    return LocalStorage.openDatabaseSync("UserInfo", "0.1", "SettingsDatabase", 100);
}


function dbInit(){
    var db = getDatabase()

    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS user(login TEXT, pass TEXT)');
    });

}

function dbInsert(ulog, upass){
    var db = getDatabase()

    if (dbGetLog() === " "){

        console.log("there is no anyone")

        db.transaction(function(tx) {
            tx.executeSql('INSERT OR REPLACE INTO user VALUES (?,?);', [ulog,upass]);
        });

    } else { dbUpdate(ulog, upass); }

}

function dbDeleteAll(){
    dbUpdate(" ", " ");
}


function dbUpdate(ulog, upass){
    var db = getDatabase();
    db.transaction(function(tx) {
        tx.executeSql(
                    'update user set login=?, pass=? where rowid = ?', [ulog, upass, 1])
    });
}

function dbGetLog(){
    var db = getDatabase()
    var ret = " ";

    db.readTransaction(function(tx) {
        var buf = tx.executeSql('SELECT * FROM user');

        for (var i = 0; i < buf.rows.length; i++) {

            ret = buf.rows.item(i).login;
            break;
        }

    });

    return ret;
}

function dbGetPass(){
    var db = getDatabase()
    var ret = " ";

    db.readTransaction(function(tx) {
        var buf = tx.executeSql('SELECT * FROM user');

        for (var i = 0; i < buf.rows.length; i++) {

            ret = buf.rows.item(i).pass;
            break;
        }

    });

    return ret;
}

function getAll(){

    return dbGetLog() + " " + dbGetPass();
}

function dbDeleteAllNO(){
    var db = getDatabase()

    db.transaction(function(tx) {
        tx.executeSql('DELETE FROM user');
    });
}
