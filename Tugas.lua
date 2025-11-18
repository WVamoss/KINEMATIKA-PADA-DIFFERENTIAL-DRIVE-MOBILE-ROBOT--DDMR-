function sysCall_init()
    ----------------------------------------------------------------
    -- Parameter Robot
    ----------------------------------------------------------------
    R = 0.05       -- jari-jari roda (meter)
    D = 0.13       -- wheelbase (meter)

    leftMotor  = sim.getObject('/LeftMotor')
    rightMotor = sim.getObject('/RightMotor')

    startTime = sim.getSimulationTime()
end

-- Fungsi untuk inverse kinematics
function setVelocity(v, omega)
    wr = (v / R) + (D / R) * omega
    wl = (v / R) - (D / R) * omega
    
    sim.setJointTargetVelocity(rightMotor, wr)
    sim.setJointTargetVelocity(leftMotor, wl)
end


function sysCall_actuation()
    t = sim.getSimulationTime() - startTime

    ------------------------------------------------------------
    -- 1. MAJU LURUS (0 ? 2 detik)
    ------------------------------------------------------------
    if t < 2 then
        setVelocity(0.3, 0)

    ------------------------------------------------------------
    -- 2. BELOK KANAN DIKIT (2 ? 3 detik)
    -- omega negatif ? belok kanan
    ------------------------------------------------------------
    elseif t < 3 then
        setVelocity(0.2, -0.8)

    ------------------------------------------------------------
    -- 3. MAJU LAGI (3 ? 4 detik)
    ------------------------------------------------------------
    elseif t < 4 then
        setVelocity(0.3, 0)

    ------------------------------------------------------------
    -- 4. BELOK KIRI DIKIT (4 ? 5 detik)
    -- omega positif ? belok kiri
    ------------------------------------------------------------
    elseif t < 5 then
        setVelocity(0.2, 0.8)

    ------------------------------------------------------------
    -- 5. MAJU LAGI SAMPAI 2 DETIK SETELAHNYA (5 ? 7 detik)
    ------------------------------------------------------------
    elseif t < 7 then
        setVelocity(0.3, 0)

    ------------------------------------------------------------
    -- 6. STOP TOTAL
    ------------------------------------------------------------
    else
        setVelocity(0, 0)
    end
end
