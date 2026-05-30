#ifndef MQTTBASIC_H
#define MQTTBASIC_H

#include <QMqttClient>
#include "websocketiodevice.h"

#define MQTT_PORT 1883
#define MQTT_VERSION 3

QT_BEGIN_NAMESPACE
namespace Ui { class MqttBasic; }
QT_END_NAMESPACE

class MqttBasic : public QObject
{
    Q_OBJECT

public:
    MqttBasic(QObject *parent = nullptr);
    ~MqttBasic();
    void vSetBroker(QString qsHost,int nPort,QString qsUsr,QString qsPwd);
    void vSetWsBroker(QString qsHost,QString qsUsr,QString qsPwd,QString qsMac);
    void vDisconnectBroker();
    void vTopicSubscription(QString);

private slots:
    void updateLogStateChange();
    void brokerDisconnected();

private:
    Ui::MqttBasic *ui;
    QMqttClient *m_client;
    WebSocketIODevice *m_device;
    int m_version;
    QString m_user,m_password;
    QString qsTemaBtI35;
    QMqttSubscription *m_subscription;
    void vIniciaConnectaClientMqtt();

public slots:
    void vPublish(QString,QString);

signals:
    void vSignalMqttConnected();
    void vSignalMqttConnecting();
    void vSignalMqttDisconnected();
    void vSignalMqttMsgRcv(QString,QString);
};
#endif // MQTTBASIC_H
