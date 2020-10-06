import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.LocalStorage 2.12
Page{

Rectangle {
    color: "white"
    width: 200
    height: 100

    Text {
        text: "?"
        anchors.horizontalCenter: parent.horizontalCenter
        function findGreetings() {
            var db = openDatabaseSync("QDeclarativeExampleDB", "1.0", "The Example QML SQL!", 1000000);

            db.transaction(
                function(tx) {
                    // Create the database if it doesn't already exist
                    tx.executeSql('CREATE TABLE IF NOT EXISTS Greeting(salutation TEXT, salutee TEXT)');

                    // Add (another) greeting row
                    tx.executeSql('INSERT INTO Greeting VALUES(?, ?)', [ 'hello', 'world' ]);

                    // Show all added greetings
                    var rs = tx.executeSql('SELECT * FROM Greeting');

                    var r = ""
                    for (var i = 0; i < rs.rows.length; i++) {
                        r += rs.rows.item(i).salutation + ", " + rs.rows.item(i).salutee + "\n"
                    }
                    text = r
                }
            )
        }
        Component.onCompleted: findGreetings()
    }
}
}
