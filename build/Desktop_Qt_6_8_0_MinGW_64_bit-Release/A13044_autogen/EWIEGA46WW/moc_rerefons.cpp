/****************************************************************************
** Meta object code from reading C++ file 'rerefons.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.8.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../rerefons.h"
#include <QtGui/qtextcursor.h>
#include <QtGui/qscreen.h>
#include <QtNetwork/QSslPreSharedKeyAuthenticator>
#include <QtNetwork/QSslError>
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'rerefons.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.8.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSRereFonsENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSRereFonsENDCLASS = QtMocHelpers::stringData(
    "RereFons",
    "brokerCanviat",
    "",
    "cmptChanged",
    "vSignalMqttConnected",
    "vSignalMqttConnecting",
    "vSignalMqttDisconnected",
    "mqttRebut",
    "mqttMsgReceived",
    "topic",
    "msg",
    "vSubscriu",
    "vMsgRebut",
    "vPublish",
    "dirResultat",
    "resultat"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSRereFonsENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
      11,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       7,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   80,    2, 0x06,    1 /* Public */,
       3,    0,   81,    2, 0x06,    2 /* Public */,
       4,    0,   82,    2, 0x06,    3 /* Public */,
       5,    0,   83,    2, 0x06,    4 /* Public */,
       6,    0,   84,    2, 0x06,    5 /* Public */,
       7,    0,   85,    2, 0x06,    6 /* Public */,
       8,    2,   86,    2, 0x06,    7 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
      11,    0,   91,    2, 0x0a,   10 /* Public */,
      12,    2,   92,    2, 0x0a,   11 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
      13,    2,   97,    2, 0x02,   14 /* Public */,
      14,    1,  102,    2, 0x02,   17 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,    9,   10,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,    2,    2,

 // methods: parameters
    QMetaType::Void, QMetaType::QString, QMetaType::QString,    2,    2,
    QMetaType::Void, QMetaType::QString,   15,

       0        // eod
};

Q_CONSTINIT const QMetaObject RereFons::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSRereFonsENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSRereFonsENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSRereFonsENDCLASS_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<RereFons, std::true_type>,
        // method 'brokerCanviat'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'cmptChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'vSignalMqttConnected'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'vSignalMqttConnecting'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'vSignalMqttDisconnected'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'mqttRebut'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'mqttMsgReceived'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'vSubscriu'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'vMsgRebut'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'vPublish'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'dirResultat'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>
    >,
    nullptr
} };

void RereFons::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<RereFons *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->brokerCanviat(); break;
        case 1: _t->cmptChanged(); break;
        case 2: _t->vSignalMqttConnected(); break;
        case 3: _t->vSignalMqttConnecting(); break;
        case 4: _t->vSignalMqttDisconnected(); break;
        case 5: _t->mqttRebut(); break;
        case 6: _t->mqttMsgReceived((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 7: _t->vSubscriu(); break;
        case 8: _t->vMsgRebut((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 9: _t->vPublish((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 10: _t->dirResultat((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (RereFons::*)();
            if (_t _q_method = &RereFons::brokerCanviat; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (RereFons::*)();
            if (_t _q_method = &RereFons::cmptChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (RereFons::*)();
            if (_t _q_method = &RereFons::vSignalMqttConnected; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (RereFons::*)();
            if (_t _q_method = &RereFons::vSignalMqttConnecting; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (RereFons::*)();
            if (_t _q_method = &RereFons::vSignalMqttDisconnected; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (RereFons::*)();
            if (_t _q_method = &RereFons::mqttRebut; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (RereFons::*)(QString , QString );
            if (_t _q_method = &RereFons::mqttMsgReceived; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 6;
                return;
            }
        }
    }
}

const QMetaObject *RereFons::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *RereFons::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSRereFonsENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int RereFons::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 11)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 11)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 11;
    }
    return _id;
}

// SIGNAL 0
void RereFons::brokerCanviat()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void RereFons::cmptChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void RereFons::vSignalMqttConnected()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void RereFons::vSignalMqttConnecting()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void RereFons::vSignalMqttDisconnected()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void RereFons::mqttRebut()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void RereFons::mqttMsgReceived(QString _t1, QString _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}
QT_WARNING_POP
