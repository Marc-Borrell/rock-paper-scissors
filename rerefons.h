#ifndef REREFONS_H
#define REREFONS_H

#include <QObject>
#include "mqttbasic.h"
#include <QtTextToSpeech>

class RereFons : public QObject
{
    Q_OBJECT
public:
    explicit RereFons(QObject *parent = nullptr);
    ~RereFons();
    MqttBasic *mqtt;
    void setBroker(const QString &szValue);
    Q_INVOKABLE void vPublish(QString,QString);
    Q_INVOKABLE void dirResultat(QString resultat);


public slots:
    void vSubscriu();
    void vMsgRebut(QString,QString);


signals:
    void brokerCanviat();
    void cmptChanged();

    void vSignalMqttConnected();
    void vSignalMqttConnecting();
    void vSignalMqttDisconnected();
    void mqttRebut();
    void mqttMsgReceived(QString topic, QString msg);

private:
    QString m_szNomBroker;
    QString m_szUsrBroker;
    QString m_szPwdBroker;
    QString m_szMac;
    int m_nCmpt;
    QString m_missatgeI35;
    QTextToSpeech *m_speech;
};

#endif // REREFONS_H
