#include "mqttbasic.h"
// #include "ui_mqttbasic.h"
#include <QDateTime>
#include <QDebug>

MqttBasic::MqttBasic(QObject *parent)
    : QObject(parent)
{
    vIniciaConnectaClientMqtt();
    m_device = NULL;
}

void MqttBasic::vIniciaConnectaClientMqtt(){
    m_client = new QMqttClient(this);

    connect(m_client, &QMqttClient::stateChanged, this, &MqttBasic::updateLogStateChange);
    connect(m_client, &QMqttClient::disconnected, this, &MqttBasic::brokerDisconnected);

    connect(m_client, &QMqttClient::messageReceived, this, [this](const QByteArray &message, const QMqttTopicName &topic) {
        const QString content = QDateTime::currentDateTime().toString()
                    + QLatin1String(" Received Topic: ")
                    + topic.name()
                    + QLatin1String(" Message: ")
                    + message
                    + QLatin1Char('\n');
        emit vSignalMqttMsgRcv(topic.name(),message);
        qDebug() << content;
    });
}

void MqttBasic::vSetBroker(QString qsHost,int nPort,QString qsUsr,QString qsPwd){
    if (m_client->state() == QMqttClient::Disconnected){
        m_client->setHostname(qsHost);
        m_client->setPort(nPort);
        if(qsUsr!="" && qsPwd!=""){
            m_client->setUsername(qsUsr);
            m_client->setPassword(qsPwd);
        }
        m_client->connectToHost();
    }
}

void MqttBasic::vSetWsBroker(QString qsHost,QString qsUsr,QString qsPwd,QString qsMac){
    m_version = MQTT_VERSION;
    m_user = qsUsr;
    m_password = qsPwd;
//    qsTemaBtI35 = "/"+ qsMac +"/btI35";
    QUrl m_url = QUrl(qsHost);

//    qDebug() << "URL: " << m_url <<
//                "Protocol: " << (m_version == 3 ? "mqttv3.1" : "mqtt") <<
//                "usr: " << m_user <<
//                "pwd: " << m_password;

    //if (m_client->state() == QMqttClient::Disconnected){
        m_device = new WebSocketIODevice;

        //m_client->setHostname(qsHost);
        m_device->setUrl(m_url);
        m_device->setProtocol(m_version == 3 ? "mqttv3.1" : "mqtt");

        connect(m_device, &WebSocketIODevice::socketConnected, this, [this]() {
            qDebug() << "WebSocket connected, initializing MQTT connection.";

            m_client->setProtocolVersion(m_version == 3 ? QMqttClient::MQTT_3_1 : QMqttClient::MQTT_3_1_1);
            m_client->setTransport(m_device, QMqttClient::IODevice);
            m_client->setUsername(m_user);
            m_client->setPassword(m_password);

//            connect(m_client, &QMqttClient::connected, this, [this]() {
//                qDebug() << "MQTT connection established";

//                m_subscription = m_client->subscribe(qsTemaBtI35);
//                if (!m_subscription) {
//                    qDebug() << "Failed to subscribe to " << qsTemaBtI35;
//                    return;
//                    // emit errorOccured();
//                }

//                connect(m_subscription, &QMqttSubscription::stateChanged,
//                        [](QMqttSubscription::SubscriptionState s) {
//                    qDebug() << "Subscription state changed:" << s;
//                });

//                connect(m_subscription, &QMqttSubscription::messageReceived,
//                        [this](QMqttMessage msg) {
//                    qDebug() << msg.topic().name().toLatin1();
//                    qDebug() << msg.payload();
//                });
//            });
            m_client->connectToHost();
        });
    //}
    if (!m_device->open(QIODevice::ReadWrite))
        qDebug() << "Could not open socket device";
}

void MqttBasic::vDisconnectBroker(){
    if (m_client->state() == QMqttClient::Connected){
        qDebug() << "Detecta que és connectat";
        m_client->disconnectFromHost();
    }else{
        qDebug() << "No detecta que és connectat";
    }
    if(m_device != NULL){
        m_client->cleanSession();
        m_device->disconnect();
        delete m_device;
        m_device = NULL;
        qDebug() << "Desconnectat";
        emit vSignalMqttDisconnected();

        disconnect(m_client);
        delete m_client;
        vIniciaConnectaClientMqtt();
    }
}

MqttBasic::~MqttBasic()
{
    vDisconnectBroker();
}

void MqttBasic::updateLogStateChange(){
    const QString content = QDateTime::currentDateTime().toString()
                    + QLatin1String(": State Change ")
                    + QString::number(m_client->state())
                    + QLatin1Char('\n');

    if(QString::number(m_client->state()) == "0"){
        qDebug() << "Desconnectat";
        emit vSignalMqttDisconnected();
    }
    if(QString::number(m_client->state()) == "1"){
        qDebug() << "Connectant";
        emit vSignalMqttConnecting();
    }
    if(QString::number(m_client->state()) == "2"){
        qDebug() << "Connectat";
        emit vSignalMqttConnected();
    }

    qDebug() << content;
}

void MqttBasic::brokerDisconnected(){
    emit vSignalMqttDisconnected();
}

void MqttBasic::vTopicSubscription(QString qs){
    auto subscription = m_client->subscribe(qs);
    if (!subscription) {
        qDebug() << QLatin1String("Could not subscribe. Is there a valid connection?");
        return;
    }
}

void MqttBasic::vPublish(QString qsTopic,QString qsMsg){
    if (m_client->publish(qsTopic, qsMsg.toUtf8()) == -1)
        qDebug() << QLatin1String("Could not publish message");
}
