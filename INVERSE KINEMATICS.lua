--========================================================
--  PERC0BAAN 2 : INVERSE KINEMATICS DDMR (10 TRIAL)
--  Robot differential drive di CoppeliaSim
--  Hubungan: (V, theta_dot) -> (omega_r, omega_l)
--========================================================

function sysCall_init()
    ------------------------------------------------------
    -- 1. Ambil handle motor kiri & kanan (pakai path absolut)
    ------------------------------------------------------
    leftMotor  = sim.getObject('/RobotBase/leftMotor')
    rightMotor = sim.getObject('/RobotBase/rightMotor')

    if leftMotor == nil or rightMotor == nil then
        sim.addStatusbarMessage('ERROR: Motor tidak ditemukan! Cek path objek.')
        return
    end

    ------------------------------------------------------
    -- 2. Parameter fisik robot (ubah sesuai robotmu)
    ------------------------------------------------------
    R = 0.05    -- jari-jari roda (meter)
    D = 0.30    -- wheel base / jarak antar roda (meter)

    ------------------------------------------------------
    -- 3. Daftar 10 trial (V, theta_dot, durasi)
    ------------------------------------------------------
    trials = {
        {V = 0.20, theta_dot = 0.00, duration = 5.0},  -- 1: lurus
        {V = 0.20, theta_dot = 0.50, duration = 5.0},  -- 2: belok kiri sedang
        {V = 0.20, theta_dot = -0.50, duration = 5.0}, -- 3: belok kanan sedang
        {V = 0.00, theta_dot = 0.80, duration = 5.0},  -- 4: berputar di tempat (kiri)
        {V = 0.00, theta_dot = -0.80, duration = 5.0}, -- 5: berputar di tempat (kanan)
        {V = 0.10, theta_dot = 0.30, duration = 5.0},  -- 6: belok kiri lambat
        {V = 0.10, theta_dot = -0.30, duration = 5.0}, -- 7: belok kanan lambat
        {V = 0.25, theta_dot = 0.00, duration = 5.0},  -- 8: lurus lebih cepat
        {V = 0.25, theta_dot = 0.60, duration = 5.0},  -- 9: belok kiri tajam
        {V = 0.25, theta_dot = -0.60, duration = 5.0}  -- 10: belok kanan tajam
    }

    currentTrial    = 1
    trialStartTime  = sim.getSimulationTime()

    sim.addStatusbarMessage('Inverse Kinematics: Trial 1 dimulai')
end


function sysCall_actuation()
    local t = sim.getSimulationTime()

    -- Jika semua trial selesai -> matikan motor
    if currentTrial > #trials then
        sim.setJointTargetVelocity(leftMotor, 0.0)
        sim.setJointTargetVelocity(rightMotor, 0.0)
        return
    end

    local trial = trials[currentTrial]

    -- Pindah trial jika durasi sudah habis
    if (t - trialStartTime) > trial.duration then
        currentTrial = currentTrial + 1

        if currentTrial <= #trials then
            trialStartTime = t
            sim.addStatusbarMessage('Inverse Kinematics: pindah ke Trial ' .. currentTrial)
        else
            sim.addStatusbarMessage('Inverse Kinematics selesai (10 trial)')
        end

        return
    end

    ------------------------------------------------------
    -- 4. Ambil target V dan theta_dot
    ------------------------------------------------------
    local V         = trial.V
    local theta_dot = trial.theta_dot

    ------------------------------------------------------
    -- 5. Hitung omega_r dan omega_l (inverse kinematics)
    ------------------------------------------------------
    local omega_r = (1/R) * V + (D/R) * theta_dot
    local omega_l = (1/R) * V - (D/R) * theta_dot

    ------------------------------------------------------
    -- 6. Set ke motor
    ------------------------------------------------------
    sim.setJointTargetVelocity(rightMotor, omega_r)
    sim.setJointTargetVelocity(leftMotor,  omega_l)

    ------------------------------------------------------
    -- 7. Tampilkan informasi ke status bar & console
    ------------------------------------------------------
    local msg = string.format(
        '[Inverse] Trial %d | V=%.2f m/s, θ̇=%.2f rad/s -> wr=%.2f rad/s, wl=%.2f rad/s',
        currentTrial, V, theta_dot, omega_r, omega_l
    )

    sim.addStatusbarMessage(msg)
    print(msg)   -- tampil di console bawah
end


function sysCall_cleanup()
    -- Matikan motor setelah simulasi selesai
    if leftMotor then sim.setJointTargetVelocity(leftMotor, 0.0) end
    if rightMotor then sim.setJointTargetVelocity(rightMotor, 0.0) end
end
