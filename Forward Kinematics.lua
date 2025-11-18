--========================================================
--  PERC0BAAN 1 : FORWARD KINEMATICS DDMR
--  Robot differential drive di CoppeliaSim
--  Hubungan: (omega_r, omega_l) -> (V, theta_dot)
--========================================================

function sysCall_init()
    ------------------------------------------------------
    -- 1. Ambil handle motor kiri & kanan (gunakan path absolut)
    ------------------------------------------------------
    leftMotor  = sim.getObject('/RobotBase/leftMotor')   -- sesuaikan path jika berbeda
    rightMotor = sim.getObject('/RobotBase/rightMotor')  -- sesuaikan path jika berbeda

    if leftMotor == nil or rightMotor == nil then
        sim.addStatusbarMessage('ERROR: Motor tidak ditemukan di Scene')
        return
    end

    ------------------------------------------------------
    -- 2. Parameter fisik robot (ubah sesuai robotmu)
    ------------------------------------------------------
    R = 0.05   -- jari-jari roda (m) (ubah sesuai robotmu, 5 cm misalnya)
    D = 0.30   -- wheel base (jarak antar roda) (ubah sesuai robotmu, 30 cm misalnya)

    ------------------------------------------------------
    -- 3. Daftar trial untuk forward kinematics
    --    Setiap trial: omega_r, omega_l, durasi (detik)
    ------------------------------------------------------
    trials = {
        {omega_r = 5.0, omega_l = 5.0, duration = 5.0},   -- trial 1: robot lurus
        {omega_r = 6.0, omega_l = 4.0, duration = 5.0},   -- trial 2: belok kiri
        {omega_r = 4.0, omega_l = 6.0, duration = 5.0},   -- trial 3: belok kanan
        {omega_r = 5.0, omega_l = -5.0, duration = 5.0},  -- trial 4: berputar di tempat
        {omega_r = 2.0, omega_l = 5.0, duration = 5.0},   -- trial 5: belok kiri pelan
        {omega_r = 5.0, omega_l = 2.0, duration = 5.0},   -- trial 6: belok kanan pelan
        {omega_r = 0.0, omega_l = 5.0, duration = 5.0},   -- trial 7: maju lurus pelan
        {omega_r = 5.0, omega_l = 0.0, duration = 5.0},   -- trial 8: maju lurus pelan
        {omega_r = 7.0, omega_l = 5.0, duration = 5.0},   -- trial 9: belok kanan lebih tajam
        {omega_r = 5.0, omega_l = 7.0, duration = 5.0}    -- trial 10: belok kiri lebih tajam
    }

    currentTrial    = 1
    trialStartTime  = sim.getSimulationTime()

    sim.addStatusbarMessage('Forward Kinematics: mulai Trial 1')
end


function sysCall_actuation()
    local t = sim.getSimulationTime()

    -- Jika semua trial sudah selesai, matikan motor
    if currentTrial > #trials then
        sim.setJointTargetVelocity(rightMotor, 0.0)
        sim.setJointTargetVelocity(leftMotor,  0.0)
        return
    end

    local trial = trials[currentTrial]

    -- Cek apakah durasi trial saat ini sudah habis
    if (t - trialStartTime) > trial.duration then
        currentTrial = currentTrial + 1

        if currentTrial <= #trials then
            trialStartTime = t
            sim.addStatusbarMessage('Forward Kinematics: pindah ke Trial ' .. currentTrial)
        else
            sim.addStatusbarMessage('Forward Kinematics: semua trial selesai')
        end

        return
    end

    --------------------------------------------------
    -- 4. Set kecepatan motor dari trial (omega_r, omega_l)
    --------------------------------------------------
    local omega_r = trial.omega_r
    local omega_l = trial.omega_l

    sim.setJointTargetVelocity(rightMotor, omega_r)
    sim.setJointTargetVelocity(leftMotor,  omega_l)

    --------------------------------------------------
    -- 5. Hitung kecepatan linier dan sudut (teoretis)
    --    V = (R/2)*(wr + wl)
    --    theta_dot = (R/(2D))*(wr - wl)
    --------------------------------------------------
    local V         = (R / 2.0)     * (omega_r + omega_l)
    local theta_dot = (R / (2.0*D)) * (omega_r - omega_l)

    --------------------------------------------------
    -- 6. Tampilkan di status bar (mudah untuk dicatat)
    --------------------------------------------------
    local msg = string.format(
        '[Forward] Trial %d | wr=%.2f rad/s, wl=%.2f rad/s -> V=%.3f m/s, theta_dot=%.3f rad/s',
        currentTrial, omega_r, omega_l, V, theta_dot
    )
    sim.addStatusbarMessage(msg)
    print(msg)   -- <== Tampilkan di console juga
end


function sysCall_cleanup()
    -- Matikan motor saat simulasi berhenti
    if rightMotor then
        sim.setJointTargetVelocity(rightMotor, 0.0)
    end
    if leftMotor then
        sim.setJointTargetVelocity(leftMotor, 0.0)
    end
end
