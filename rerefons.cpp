#include "rerefons.h"
#include <QDebug>
#include <QTextToSpeech>

RereFons::RereFons(QObject *parent)
    : QObject{parent}
{
    m_szNomBroker = "ws://formacio.things.cat:9001";
    m_szUsrBroker = "ecat";
    m_szPwdBroker = "clotClot";
    m_szMac = "1234567890A";

    mqtt = new MqttBasic;

    connect(mqtt,SIGNAL(vSignalMqttConnected()),this,SIGNAL(vSignalMqttConnected()));
    connect(mqtt,SIGNAL(vSignalMqttConnecting()),this,SIGNAL(vSignalMqttConnecting()));
    connect(mqtt,SIGNAL(vSignalMqttDisconnected()),this,SIGNAL(vSignalMqttDisconnected()));

    connect(mqtt,SIGNAL(vSignalMqttConnected()),this,SLOT(vSubscriu()));
    connect(mqtt,SIGNAL(vSignalMqttMsgRcv(QString,QString)),this,SLOT(vMsgRebut(QString,QString)));
    //    void vSignalMqttMsgRcv(QString,QString);

    setBroker("res");

    m_speech = new QTextToSpeech(this);
    m_speech->setLocale(QLocale(QLocale::Catalan, QLocale::Spain));

}

RereFons::~RereFons(){
    mqtt->vDisconnectBroker();
    delete mqtt;
}

void RereFons::setBroker(const QString &szValue){
    mqtt->vSetWsBroker(m_szNomBroker,m_szUsrBroker,m_szPwdBroker,m_szMac);

    emit brokerCanviat();
}

void RereFons::vPublish(QString tema,QString msg){
    mqtt->vPublish(tema, msg);
}

void  RereFons::vSubscriu(){
    mqtt->vTopicSubscription("/94B5553697E8/#");
}

void RereFons::vMsgRebut(QString tema ,QString msg){
    QString qsM = "Tema: "+tema+", missatge: "+msg;
    qDebug() << qsM;
    emit mqttMsgReceived(tema, msg);
}

void RereFons::dirResultat(QString resultat)
{
    if (!m_speech)
        return;

    if (resultat == "guanyes")
        m_speech->say("Guanyes");
    else if (resultat == "empates")
        m_speech->say("Empates");
    else if (resultat == "perds")
        m_speech->say("Perds");
}

