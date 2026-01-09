#ifndef AGVCONTROLLER_H
#define AGVCONTROLLER_H

#include <QObject>
#include <QTimer>
#include <QDebug>
#include <QVariant>

class AgvController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int batteryLevel READ batteryLevel NOTIFY batteryLevelChanged)
    Q_PROPERTY(double speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(QString mode READ mode WRITE setMode NOTIFY modeChanged)
    Q_PROPERTY(bool connected READ connected NOTIFY connectedChanged)
    Q_PROPERTY(bool systemReady READ systemReady NOTIFY systemReadyChanged)
    Q_PROPERTY(int currentStep READ currentStep NOTIFY currentStepChanged)
    Q_PROPERTY(QString stepDescription READ stepDescription NOTIFY stepDescriptionChanged)

    // New properties for UI
    Q_PROPERTY(bool manualControlEnabled READ manualControlEnabled WRITE setManualControlEnabled NOTIFY manualControlEnabledChanged)
    Q_PROPERTY(int forkLiftPosition READ forkLiftPosition NOTIFY forkLiftPositionChanged)
    Q_PROPERTY(QString accelProfile READ accelProfile WRITE setAccelProfile NOTIFY accelProfileChanged)
    Q_PROPERTY(QString userLevel READ userLevel NOTIFY userLevelChanged)
    Q_PROPERTY(bool frontClear READ frontClear NOTIFY safetySensorsChanged)
    Q_PROPERTY(bool rearClear READ rearClear NOTIFY safetySensorsChanged)
    Q_PROPERTY(bool plcStatus READ plcStatus NOTIFY plcStatusChanged)
    Q_PROPERTY(int currentAlarmCount READ currentAlarmCount NOTIFY alarmCountChanged)

public:
    explicit AgvController(QObject *parent = nullptr);

    int batteryLevel() const;
    double speed() const;
    QString mode() const;
    bool connected() const;
    bool systemReady() const;
    int currentStep() const;
    QString stepDescription() const;

    bool manualControlEnabled() const;
    int forkLiftPosition() const;
    QString accelProfile() const;
    QString userLevel() const;
    bool frontClear() const;
    bool rearClear() const;
    bool plcStatus() const;
    int currentAlarmCount() const;

public slots:
    void setMode(const QString &mode);
    void toggleConnection();
    void acknowledgeAlarm();
    void resetSystem();
    void manualMove(const QString &direction);
    void toggleForkLift(); // Moves it up/down
    void setManualControlEnabled(bool enabled);
    void setAccelProfile(const QString &profile);

signals:
    void batteryLevelChanged();
    void speedChanged();
    void modeChanged();
    void connectedChanged();
    void systemReadyChanged();
    void currentStepChanged();
    void stepDescriptionChanged();

    void manualControlEnabledChanged();
    void forkLiftPositionChanged();
    void accelProfileChanged();
    void userLevelChanged();
    void safetySensorsChanged();
    void plcStatusChanged();
    void alarmCountChanged();

    void newAlarm(const QString &code, const QString &message, const QString &level);

private slots:
    void simulateData();

private:
    int m_batteryLevel;
    double m_speed;
    QString m_mode;
    bool m_connected;
    bool m_systemReady;
    int m_currentStep;
    QString m_stepDescription;

    bool m_manualControlEnabled;
    int m_forkLiftPosition;
    QString m_accelProfile;
    QString m_userLevel;
    bool m_frontClear;
    bool m_rearClear;
    bool m_plcStatus;
    int m_alarmCount;

    QTimer *m_simulationTimer;
    QStringList m_steps;
};

#endif // AGVCONTROLLER_H
