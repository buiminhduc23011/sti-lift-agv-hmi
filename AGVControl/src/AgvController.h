#ifndef AGVCONTROLLER_H
#define AGVCONTROLLER_H

#include <QObject>
#include <QTimer>
#include <QDebug>

class AgvController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int batteryLevel READ batteryLevel NOTIFY batteryLevelChanged)
    Q_PROPERTY(double speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(QString mode READ mode WRITE setMode NOTIFY modeChanged)
    Q_PROPERTY(bool connected READ connected NOTIFY connectedChanged)
    Q_PROPERTY(bool systemReady READ systemReady NOTIFY systemReadyChanged)
    Q_PROPERTY(int currentStep READ currentStep NOTIFY currentStepChanged)

public:
    explicit AgvController(QObject *parent = nullptr);

    int batteryLevel() const;
    double speed() const;
    QString mode() const;
    bool connected() const;
    bool systemReady() const;
    int currentStep() const;

public slots:
    void setMode(const QString &mode);
    void toggleConnection();
    void acknowledgeAlarm();
    void resetSystem();
    void manualMove(const QString &direction);
    void toggleForkLift();

signals:
    void batteryLevelChanged();
    void speedChanged();
    void modeChanged();
    void connectedChanged();
    void systemReadyChanged();
    void currentStepChanged();
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
    QTimer *m_simulationTimer;
};

#endif // AGVCONTROLLER_H
