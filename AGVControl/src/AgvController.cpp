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
{
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
}

void AgvController::resetSystem()
{
    m_systemReady = true;
    m_currentStep = 0;
    emit systemReadyChanged();
    emit currentStepChanged();
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
}

void AgvController::simulateData()
{
    // Simulate battery drain
    if (m_batteryLevel > 0 && QRandomGenerator::global()->bounded(10) > 8) {
        m_batteryLevel--;
        emit batteryLevelChanged();
    }

    // Simulate random alarms
    if (QRandomGenerator::global()->bounded(100) > 95) {
        emit newAlarm("W-204", "Path Obstacle Detected", "WARN");
    }

    // Simulate speed fluctuation if moving
    if (m_speed > 0) {
         m_speed = 1.0 + (QRandomGenerator::global()->generateDouble() * 0.5);
         // Decay speed
         if (QRandomGenerator::global()->bounded(10) > 5) m_speed = 0;
         emit speedChanged();
    }

    if (m_mode == "AUTO" && m_systemReady) {
        // Simulate step progression
         if (QRandomGenerator::global()->bounded(10) > 7) {
            m_currentStep++;
            emit currentStepChanged();
         }
         m_speed = 2.5; // Auto speed
         emit speedChanged();
    }
}
