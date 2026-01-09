#include "AgvController.h"
#include <QRandomGenerator>

AgvController::AgvController(QObject *parent)
    : QObject(parent)
    , m_batteryLevel(85)
    , m_speed(0.0)
    , m_mode("MANUAL")
    , m_connected(true)
    , m_systemReady(true)
    , m_currentStep(0)
    , m_stepDescription("Idle")
    , m_manualControlEnabled(false)
    , m_forkLiftPosition(0)
    , m_accelProfile("NORMAL")
    , m_userLevel("ADMINISTRATOR")
    , m_frontClear(true)
    , m_rearClear(true)
    , m_plcStatus(true)
    , m_alarmCount(3) // Initial mocked count
{
    m_steps << "Idle" << "Move to Station A" << "Load Cargo" << "Move to Station B" << "Unload Cargo" << "Return Home";

    m_simulationTimer = new QTimer(this);
    connect(m_simulationTimer, &QTimer::timeout, this, &AgvController::simulateData);
    m_simulationTimer->start(1000); // Update every second
}

int AgvController::batteryLevel() const { return m_batteryLevel; }
double AgvController::speed() const { return m_speed; }
QString AgvController::mode() const { return m_mode; }
bool AgvController::connected() const { return m_connected; }
bool AgvController::systemReady() const { return m_systemReady; }
int AgvController::currentStep() const { return m_currentStep; }
QString AgvController::stepDescription() const { return m_stepDescription; }

bool AgvController::manualControlEnabled() const { return m_manualControlEnabled; }
int AgvController::forkLiftPosition() const { return m_forkLiftPosition; }
QString AgvController::accelProfile() const { return m_accelProfile; }
QString AgvController::userLevel() const { return m_userLevel; }
bool AgvController::frontClear() const { return m_frontClear; }
bool AgvController::rearClear() const { return m_rearClear; }
bool AgvController::plcStatus() const { return m_plcStatus; }
int AgvController::currentAlarmCount() const { return m_alarmCount; }


void AgvController::setMode(const QString &mode)
{
    if (m_mode != mode) {
        m_mode = mode;
        emit modeChanged();

        // Reset speed when changing modes
        m_speed = 0.0;
        emit speedChanged();
    }
}

void AgvController::toggleConnection()
{
    m_connected = !m_connected;
    emit connectedChanged();
}

void AgvController::acknowledgeAlarm()
{
    qDebug() << "Alarm acknowledged";
    if (m_alarmCount > 0) {
        m_alarmCount--;
        emit alarmCountChanged();
    }
}

void AgvController::resetSystem()
{
    m_systemReady = true;
    m_currentStep = 0;
    m_stepDescription = m_steps[0];
    m_alarmCount = 0;

    emit systemReadyChanged();
    emit currentStepChanged();
    emit stepDescriptionChanged();
    emit alarmCountChanged();
    qDebug() << "System reset";
}

void AgvController::manualMove(const QString &direction)
{
    if (m_mode != "MANUAL") return;
    qDebug() << "Moving" << direction;
    // Simulate speed spike
    m_speed = 1.5;
    emit speedChanged();
}

void AgvController::toggleForkLift()
{
    qDebug() << "Toggling Forklift";
    if (m_forkLiftPosition == 0) m_forkLiftPosition = 100;
    else m_forkLiftPosition = 0;
    emit forkLiftPositionChanged();
}

void AgvController::setManualControlEnabled(bool enabled)
{
    if (m_manualControlEnabled != enabled) {
        m_manualControlEnabled = enabled;
        emit manualControlEnabledChanged();
    }
}

void AgvController::setAccelProfile(const QString &profile)
{
    if (m_accelProfile != profile) {
        m_accelProfile = profile;
        emit accelProfileChanged();
    }
}

void AgvController::simulateData()
{
    // Simulate battery drain
    if (m_batteryLevel > 0 && QRandomGenerator::global()->bounded(100) > 98) {
        m_batteryLevel--;
        emit batteryLevelChanged();
    }

    // Simulate random alarms
    if (QRandomGenerator::global()->bounded(100) > 98) {
        emit newAlarm("W-204", "Path Obstacle Detected", "WARN");
        m_alarmCount++;
        emit alarmCountChanged();
    }

    // Simulate speed fluctuation if moving
    if (m_speed > 0) {
         m_speed = 1.0 + (QRandomGenerator::global()->generateDouble() * 0.5);
         // Decay speed
         if (QRandomGenerator::global()->bounded(10) > 5) m_speed = 0;
         emit speedChanged();
    }

    if (m_mode == "AUTO" && m_systemReady && m_currentStep < m_steps.size() - 1) {
        // Simulate step progression
         if (QRandomGenerator::global()->bounded(100) > 90) {
            m_currentStep++;
            m_stepDescription = m_steps[m_currentStep];
            emit currentStepChanged();
            emit stepDescriptionChanged();
         }
         m_speed = 2.5; // Auto speed
         emit speedChanged();
    } else if (m_mode == "AUTO" && m_currentStep >= m_steps.size() - 1) {
        // Loop back
        if (QRandomGenerator::global()->bounded(100) > 90) {
            m_currentStep = 0;
            m_stepDescription = m_steps[0];
            emit currentStepChanged();
            emit stepDescriptionChanged();
        }
    }

    // Simulate sensor flickers
    if (QRandomGenerator::global()->bounded(100) > 95) {
        m_frontClear = !m_frontClear;
        emit safetySensorsChanged();
    }
}
