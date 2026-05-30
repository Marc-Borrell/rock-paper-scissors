import QtQuick
import QtQuick.Controls
import Qt.labs.settings 1.0
import desDel.rerefons 1.0

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("RockPaperScissors")

    property string playerChoice: ""
    property string pcChoice: ""
    property string result: ""
    property bool isDarkMode: false
    property int playerWins: 0
    property int pcWins: 0
    property bool useYellowForTie: true
    property string rockButton: "/94B5553697E8/btIO0"
    property string paperButton: "/94B5553697E8/btI34"
    property string scissorsButton: "/94B5553697E8/btI35"

    Settings {
        id: gameSettings
        property int savedPlayerWins: 0
        property int savedPcWins: 0
        property bool savedDarkMode: false
        property bool savedUseYellowForTie: true
        property string savedBroker: "ws://formacio.things.cat:9001"
        property string savedUser: "ecat"
        property string savedPassword: "clotClot"
        property string savedMac: "94B5553697E8"
        property string savedRockButton: "/94B5553697E8/btIO0"
        property string savedPaperButton: "/94B5553697E8/btI34"
        property string savedScissorsButton: "/94B5553697E8/btI35"
    }

    RereFons {
        id: rf
        onMqttMsgReceived: (topic, message) => {
            buttonsMqtt(topic)
        }
    }

    Component.onCompleted: {
        playerWins = gameSettings.savedPlayerWins;
        pcWins = gameSettings.savedPcWins;
        isDarkMode = gameSettings.savedDarkMode;
        useYellowForTie = gameSettings.savedUseYellowForTie;
        rockButton = gameSettings.savedRockButton;
        paperButton = gameSettings.savedPaperButton;
        scissorsButton = gameSettings.savedScissorsButton;

        rf.m_szNomBroker = gameSettings.savedBroker;
        rf.m_szUsrBroker = gameSettings.savedUser;
        rf.m_szPwdBroker = gameSettings.savedPassword;
        rf.m_szMac = gameSettings.savedMac;
        rf.setBroker("res");

        updateTheme();
    }

    function updateTheme() {
        if (isDarkMode) {
            gameBackground.color = "#333333";
            configBackground.color = "#222222";
            headerText.color = "white";
            txtPlayerWins.color = "white";
            txtPcWins.color = "white";
            darkModeText.color = "white";
            mqttSettingsTitle.color = "white";
            brokerLabel.color = "white";
            userLabel.color = "white";
            passwordLabel.color = "white";
            macLabel.color = "white";
            tieColorText.color = "white";
            bindingsTitle.color = "white";
            rockBindingLabel.color = "white";
            paperBindingLabel.color = "white";
            scissorsBindingLabel.color = "white";
        } else {
            gameBackground.color = "yellow";
            configBackground.color = "#f0f0f0";
            headerText.color = "darkblue";
            txtPlayerWins.color = "black";
            txtPcWins.color = "black";
            darkModeText.color = "black";
            mqttSettingsTitle.color = "black";
            brokerLabel.color = "black";
            userLabel.color = "black";
            passwordLabel.color = "black";
            macLabel.color = "black";
            tieColorText.color = "black";
            bindingsTitle.color = "black";
            rockBindingLabel.color = "black";
            paperBindingLabel.color = "black";
            scissorsBindingLabel.color = "black";
        }
    }

    function decideWinner(player, pc) {
        if (player === pc) {
            return "Tie";
        }
        if ((player === "Rock" && pc === "Scissors") ||
            (player === "Paper" && pc === "Rock") ||
            (player === "Scissors" && pc === "Paper")) {
            playerWins++;
            gameSettings.savedPlayerWins = playerWins;
            return "You win";
        }
        pcWins++;
        gameSettings.savedPcWins = pcWins;
        return "You lose";
    }

    function generateRandomChoice() {
        var choices = ["Rock", "Paper", "Scissors"];
        var randomIndex = Math.floor(Math.random() * choices.length);
        if(randomIndex == 0){
            return "Rock";
        } else if(randomIndex == 1){
            return "Paper";
        } else if (randomIndex == 2) {
            return "Scissors";
        }
    }

    function updateChoices(player) {
        playerChoice = player;
        pcChoice = generateRandomChoice();
        result = decideWinner(playerChoice, pcChoice);

        imgPlayer.source = "qrc:/img/" + playerChoice.toLowerCase() + ".png";
        imgPC.source = "qrc:/img/" + pcChoice.toLowerCase() + ".png";

        if (result === "You win") {
            gameBackground.state = "usuariGuanya";
            rf.vPublish("/" + gameSettings.savedMac + "/jsonLeds", "{\"ledW\": false, \"ledR\": 0, \"ledY\": 0, \"ledG\": 1}");
            rf.dirResultat("guanyes")
        } else if (result === "You lose") {
            gameBackground.state = "usuariPerd";
            rf.vPublish("/" + gameSettings.savedMac + "/jsonLeds", "{\"ledW\": false, \"ledR\": 1, \"ledY\": 0, \"ledG\": 0}");
            rf.dirResultat("perds")
        } else {
            gameBackground.state = "usuariEmpata";
            // Usar luz amarilla o blanca según configuración
            if (useYellowForTie) {
                rf.vPublish("/" + gameSettings.savedMac + "/jsonLeds", "{\"ledW\": false, \"ledR\": 0, \"ledY\": 1, \"ledG\": 0}");
                rf.dirResultat("empates")
            } else {
                rf.vPublish("/" + gameSettings.savedMac + "/jsonLeds", "{\"ledW\": true, \"ledR\": 0, \"ledY\": 0, \"ledG\": 0}");

            }
        }
    }

    function buttonsMqtt(topic) {
        if (topic === rockButton) {
            updateChoices("Rock")
        } else if (topic === paperButton) {
            updateChoices("Paper")
        } else if (topic === scissorsButton) {
            updateChoices("Scissors")
        }
    }

    function resetStats() {
        playerWins = 0;
        pcWins = 0;
        gameSettings.savedPlayerWins = 0;
        gameSettings.savedPcWins = 0;
    }

    function saveMqttSettings() {
        gameSettings.savedBroker = brokerInput.text;
        gameSettings.savedUser = userInput.text;
        gameSettings.savedPassword = passwordInput.text;
        gameSettings.savedMac = macInput.text;

        rf.m_szNomBroker = brokerInput.text;
        rf.m_szUsrBroker = userInput.text;
        rf.m_szPwdBroker = passwordInput.text;
        rf.m_szMac = macInput.text;

        if (!rockBindingInput.text.includes(macInput.text)) {
            rockButton = "/" + macInput.text + "/btIO0";
            paperButton = "/" + macInput.text + "/btI34";
            scissorsButton = "/" + macInput.text + "/btI35";

            rockBindingInput.text = rockButton;
            paperBindingInput.text = paperButton;
            scissorsBindingInput.text = scissorsButton;

            gameSettings.savedRockButton = rockButton;
            gameSettings.savedPaperButton = paperButton;
            gameSettings.savedScissorsButton = scissorsButton;
        }

    }

    function saveButtonBindings() {
        rockButton = rockBindingInput.text;
        paperButton = paperBindingInput.text;
        scissorsButton = scissorsBindingInput.text;

        gameSettings.savedRockButton = rockButton;
        gameSettings.savedPaperButton = paperButton;
        gameSettings.savedScissorsButton = scissorsButton;
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 0

        Item {
            Rectangle {
                id: gameBackground
                anchors.fill: parent
                property alias colorRect: gameBackground.color
                color: isDarkMode ? "#333333" : "yellow"

                Text {
                    id: txtResult
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 150
                    color: isDarkMode ? "white" : "darkblue"
                    text: result === "" ? "?" : result
                    font.pixelSize: 40
                    font.bold: true
                }

                Button {
                    id: configButton
                    text: ""
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.margins: 10
                    rightPadding: 50
                    topPadding: 50
                    onClicked: swipeView.currentIndex = 1

                    Image {
                        source: "qrc:/img/settings.png"
                        anchors.centerIn: parent
                        width: 40
                        height: 40
                    }
                }

                Rectangle {
                    id: btR
                    width: 100
                    height: 100
                    radius: 30
                    x: 100
                    y: 350
                    color: "orange"
                    border.color: isDarkMode ? "white" : "darkblue"
                    border.width: 2

                    Image {
                        source: "qrc:/img/rock.png"
                        anchors.centerIn: parent
                        width: 80
                        height: 80
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: updateChoices("Rock")
                    }
                }

                Rectangle {
                    id: btP
                    width: 100
                    height: 100
                    radius: 30
                    x: 250
                    y: 350
                    color: "orange"
                    border.color: isDarkMode ? "white" : "darkblue"
                    border.width: 2

                    Image {
                        source: "qrc:/img/paper.png"
                        anchors.centerIn: parent
                        width: 80
                        height: 80
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: updateChoices("Paper")
                    }
                }

                Rectangle {
                    id: btS
                    width: 100
                    height: 100
                    radius: 30
                    x: 400
                    y: 350
                    color: "orange"
                    border.color: isDarkMode ? "white" : "darkblue"
                    border.width: 2

                    Image {
                        source: "qrc:/img/scissors.png"
                        anchors.centerIn: parent
                        width: 80
                        height: 80
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: updateChoices("Scissors")
                    }
                }

                Rectangle {
                    id: choicesRect
                    width: parent.width
                    height: 100
                    color: "orange"
                    y: 250

                    Item {
                        anchors.centerIn: parent
                        width: childrenRect.width
                        height: childrenRect.height

                        Item {
                            id: playerColumn
                            width: 80
                            height: 100
                            anchors.left: parent.left

                            Text {
                                text: "Your choice"
                                font.pixelSize: 16
                                color: "black"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Image {
                                id: imgPlayer
                                width: 80
                                height: 80
                                source: ""
                                anchors.top: parent.top
                                anchors.topMargin: 20
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }

                        Item {
                            id: pcColumn
                            width: 80
                            height: 100
                            anchors.left: playerColumn.right
                            anchors.leftMargin: 50

                            Text {
                                text: "PC's choice"
                                font.pixelSize: 16
                                color: "black"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Image {
                                id: imgPC
                                width: 80
                                height: 80
                                source: ""
                                anchors.top: parent.top
                                anchors.topMargin: 20
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                }

                states: [
                    State {
                        name: "usuariGuanya"
                        PropertyChanges {
                            target: gameBackground
                            color: isDarkMode ? "#1e4d1e" : "lime"
                        }
                    },
                    State {
                        name: "usuariEmpata"
                        PropertyChanges {
                            target: gameBackground
                            color: isDarkMode ? "#1e4d4d" : "cyan"
                        }
                    },
                    State {
                        name: "usuariPerd"
                        PropertyChanges {
                            target: gameBackground
                            color: isDarkMode ? "#4d1e1e" : "red"
                        }
                    }
                ]

                transitions: [
                    Transition {
                        from: "*"
                        to: "usuariGuanya"
                        ColorAnimation {
                            duration: 1000
                        }
                        NumberAnimation {
                            target: gameBackground
                            property: "angleLletra"
                            duration: 500
                            easing.type: Easing.OutBounce
                        }
                        PropertyAnimation {
                            target: gameBackground
                            property: "scale"
                            from: 1
                            to: 1.2
                            duration: 500
                            easing.type: Easing.OutBack
                        }
                    },
                    Transition {
                        from: "*"
                        to: "usuariEmpata"
                        ColorAnimation {
                            duration: 1000
                        }
                        NumberAnimation {
                            target: gameBackground
                            property: "angleLletra"
                            duration: 500
                            easing.type: Easing.InOutQuart
                        }
                        PropertyAnimation {
                            target: gameBackground
                            property: "scale"
                            from: 1
                            to: 1.1
                            duration: 300
                            easing.type: Easing.InOut
                        }
                    },
                    Transition {
                        from: "*"
                        to: "usuariPerd"
                        ColorAnimation {
                            duration: 1000
                        }
                        NumberAnimation {
                            target: gameBackground
                            property: "angleLletra"
                            duration: 500
                            easing.type: Easing.OutBounce
                        }
                        RotationAnimation {
                            target: gameBackground
                            from: 0
                            to: 1000
                            duration: 1200
                            easing.type: Easing.OutElastic
                        }
                    }
                ]
            }
        }

        Item {
            Rectangle {
                id: configBackground
                anchors.fill: parent
                color: isDarkMode ? "#222222" : "#f0f0f0"

                Flickable {
                    anchors.fill: parent
                    contentWidth: parent.width
                    contentHeight: configContent.height + 50
                    clip: true

                    Item {
                        id: configContent
                        width: parent.width * 0.8
                        height: buttonsRow.y + buttonsRow.height + 50
                        anchors.horizontalCenter: parent.horizontalCenter

                        Text {
                            id: headerText
                            text: "Configuración"
                            font.pixelSize: 28
                            font.bold: true
                            color: isDarkMode ? "white" : "darkblue"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Item {
                            id: darkModeRow
                            width: parent.width
                            height: 50
                            anchors.top: headerText.bottom
                            anchors.topMargin: 20

                            Text {
                                id: darkModeText
                                text: "Modo oscuro:"
                                font.pixelSize: 18
                                color: isDarkMode ? "white" : "black"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                            }

                            Switch {
                                id: darkModeSwitch
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                checked: isDarkMode
                                onToggled: {
                                    isDarkMode = checked;
                                    gameSettings.savedDarkMode = isDarkMode;
                                    updateTheme();
                                }
                            }
                        }

                        Item {
                            id: tieColorRow
                            width: parent.width
                            height: 50
                            anchors.top: darkModeRow.bottom
                            anchors.topMargin: 10

                            Text {
                                id: tieColorText
                                text: "Color para empate:"
                                font.pixelSize: 18
                                color: isDarkMode ? "white" : "black"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                            }

                            Row {
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                spacing: 10

                                RadioButton {
                                    id: yellowRadio
                                    text: "Amarillo"
                                    checked: useYellowForTie
                                    onClicked: {
                                        useYellowForTie = true;
                                        gameSettings.savedUseYellowForTie = true;
                                    }
                                }

                                RadioButton {
                                    id: whiteRadio
                                    text: "Blanco"
                                    checked: !useYellowForTie
                                    onClicked: {
                                        useYellowForTie = false;
                                        gameSettings.savedUseYellowForTie = false;
                                    }
                                }
                            }
                        }

                        Rectangle {
                            id: statsRect
                            width: parent.width
                            height: 120
                            anchors.top: tieColorRow.bottom
                            anchors.topMargin: 20
                            color: isDarkMode ? "#444444" : "white"
                            border.color: isDarkMode ? "#555555" : "#cccccc"
                            radius: 10

                            Text {
                                id: statsTitle
                                text: "Estadísticas"
                                font.pixelSize: 20
                                font.bold: true
                                color: isDarkMode ? "white" : "black"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin: 10
                            }

                            Item {
                                width: childrenRect.width
                                height: childrenRect.height
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: statsTitle.bottom
                                anchors.topMargin: 15

                                Text {
                                    id: txtPlayerWins
                                    text: "Victorias jugador: " + playerWins
                                    font.pixelSize: 16
                                    color: isDarkMode ? "white" : "black"
                                    anchors.right: parent.horizontalCenter
                                    anchors.rightMargin: 15
                                }

                                Text {
                                    id: txtPcWins
                                    text: "Victorias PC: " + pcWins
                                    font.pixelSize: 16
                                    color: isDarkMode ? "white" : "black"
                                    anchors.left: parent.horizontalCenter
                                    anchors.leftMargin: 15
                                }
                            }
                        }

                        Rectangle {
                            id: mqttSettingsRect
                            width: parent.width
                            height: 240
                            anchors.top: statsRect.bottom
                            anchors.topMargin: 20
                            color: isDarkMode ? "#444444" : "white"
                            border.color: isDarkMode ? "#555555" : "#cccccc"
                            radius: 10

                            Text {
                                id: mqttSettingsTitle
                                text: "Configuración MQTT"
                                font.pixelSize: 20
                                font.bold: true
                                color: isDarkMode ? "white" : "black"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin: 10
                            }

                            Column {
                                anchors.top: mqttSettingsTitle.bottom
                                anchors.topMargin: 10
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                spacing: 10

                                Row {
                                    width: parent.width
                                    spacing: 10

                                    Text {
                                        id: brokerLabel
                                        text: "Broker:"
                                        font.pixelSize: 16
                                        color: isDarkMode ? "white" : "black"
                                        width: 100
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    TextField {
                                        id: brokerInput
                                        width: parent.width - brokerLabel.width - 10
                                        text: rf.m_szNomBroker
                                        placeholderText: "ws://formacio.things.cat:9001"
                                    }
                                }

                                Row {
                                    width: parent.width
                                    spacing: 10

                                    Text {
                                        id: userLabel
                                        text: "Usuario:"
                                        font.pixelSize: 16
                                        color: isDarkMode ? "white" : "black"
                                        width: 100
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    TextField {
                                        id: userInput
                                        width: parent.width - userLabel.width - 10
                                        text: rf.m_szUsrBroker
                                        placeholderText: "ecat"
                                    }
                                }

                                Row {
                                    width: parent.width
                                    spacing: 10

                                    Text {
                                        id: passwordLabel
                                        text: "Contraseña:"
                                        font.pixelSize: 16
                                        color: isDarkMode ? "white" : "black"
                                        width: 100
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    TextField {
                                        id: passwordInput
                                        width: parent.width - passwordLabel.width - 10
                                        text: rf.m_szPwdBroker
                                        placeholderText: "clotClot"
                                        echoMode: TextInput.Password
                                    }
                                }

                                Row {
                                    width: parent.width
                                    spacing: 10

                                    Text {
                                        id: macLabel
                                        text: "MAC:"
                                        font.pixelSize: 16
                                        color: isDarkMode ? "white" : "black"
                                        width: 100
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    TextField {
                                        id: macInput
                                        width: parent.width - macLabel.width - 10
                                        text: rf.m_szMac
                                        placeholderText: "94B5553697E8"
                                    }
                                }

                                Button {
                                    text: "Guardar configuración MQTT"
                                    anchors.right: parent.right
                                    onClicked: saveMqttSettings()
                                }
                            }
                        }

                        Rectangle {
                            id: buttonBindingsRect
                            width: parent.width
                            height: 200
                            anchors.top: mqttSettingsRect.bottom
                            anchors.topMargin: 20
                            color: isDarkMode ? "#444444" : "white"
                            border.color: isDarkMode ? "#555555" : "#cccccc"
                            radius: 10

                            Text {
                                id: bindingsTitle
                                text: "Relación de botones"
                                font.pixelSize: 20
                                font.bold: true
                                color: isDarkMode ? "white" : "black"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin: 10
                            }

                            Column {
                                anchors.top: bindingsTitle.bottom
                                anchors.topMargin: 10
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                spacing: 10

                                Row {
                                    width: parent.width
                                    spacing: 10

                                    Text {
                                        id: rockBindingLabel
                                        text: "Pedra:"
                                        font.pixelSize: 16
                                        color: isDarkMode ? "white" : "black"
                                        width: 100
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    TextField {
                                        id: rockBindingInput
                                        width: parent.width - rockBindingLabel.width - 10
                                        text: rockButton
                                        placeholderText: "/" + macInput.text + "/btIO0"
                                    }
                                }

                                Row {
                                    width: parent.width
                                    spacing: 10

                                    Text {
                                        id: paperBindingLabel
                                        text: "Paper:"
                                        font.pixelSize: 16
                                        color: isDarkMode ? "white" : "black"
                                        width: 100
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    TextField {
                                        id: paperBindingInput
                                        width: parent.width - paperBindingLabel.width - 10
                                        text: paperButton
                                        placeholderText: "/" + macInput.text + "/btI34"
                                    }
                                }

                                Row {
                                    width: parent.width
                                    spacing: 10

                                    Text {
                                        id: scissorsBindingLabel
                                        text: "Tisora:"
                                        font.pixelSize: 16
                                        color: isDarkMode ? "white" : "black"
                                        width: 100
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    TextField {
                                        id: scissorsBindingInput
                                        width: parent.width - scissorsBindingLabel.width - 10
                                        text: scissorsButton
                                        placeholderText: "/" + macInput.text + "/btI35"
                                    }
                                }

                                Button {
                                    text: "Guardar relación de botones"
                                    anchors.right: parent.right
                                    onClicked: saveButtonBindings()
                                }
                            }
                        }

                        Item {
                            id: buttonsRow
                            width: parent.width
                            height: 50
                            anchors.top: buttonBindingsRect.bottom
                            anchors.topMargin: 20

                            Button {
                                id: resetButton
                                text: "Reiniciar estadísticas"
                                anchors.right: parent.horizontalCenter
                                anchors.rightMargin: 10
                                onClicked: resetStats()
                            }

                            Button {
                                id: backButton
                                text: "Volver al juego"
                                anchors.left: parent.horizontalCenter
                                anchors.leftMargin: 10
                                onClicked: swipeView.currentIndex = 0
                            }
                        }
                    }
                }
            }
        }
    }

    PageIndicator {
        id: indicator
        count: swipeView.count
        currentIndex: swipeView.currentIndex
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
