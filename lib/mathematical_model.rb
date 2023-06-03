require_relative 'constants'
require_relative 'interpolation_methods'
require_relative 'atmosphere_parameters'

# Вспомогательные уравнения

# Тяга РН
def thrust(height, t)
    if t >= T_AYT
        return 0
    else
        P_0 + S_A * (P_0_N - AtmosphereParameters.new(height).parameter_pressure)
    end
end

# Что-то непонятное
def A(height)
    h = AtmosphereParameters.new(height)

    h.parameter_density * (h.parameter_sound_velocity ** 2) / 2 * S_M
end

# Значение числа Маха
def mah(velocity, height)
    velocity/AtmosphereParameters.new(height).parameter_sound_velocity
end

# Текущая масса
def current_mass(t)
    if t >= T_AYT
        MASS_0 - D_MASS_DT * (T_AYT - 0.01)
    else
        MASS_0 - D_MASS_DT * t
    end
end

def n_alpha_R(velocity, height, t)
    current_mah = mah(velocity, height)
    acceleration = AtmosphereParameters.new(height).parameter_acceleration_free_fall

     (3.14159 / 180 * thrust(height, t) + interpolation_c_r_alpha_pr(current_mah) * 
        (current_mah ** 2) * A(height)) / (current_mass(t) * acceleration) 
end

def alpha_pr(n_z_a, velocity, height, t)
    (n_z_a.abs + 2) / n_alpha_R(velocity, height, t)
end

def alpha(velocity, height, t)
    1 / n_alpha_R(velocity, height, t)
end

def betta(n_z_a, velocity, height, t)
    (-n_z_a) / n_alpha_R(velocity, height, t)
end

def force_y_a(velocity, height, t)
    current_mah = mah(velocity, height)

    interpolation_c_r_alpha_pr(current_mah) * (current_mah ** 2) * A(height) * alpha(velocity, height, t)
end

def force_z_a(velocity, height, t, n_z_a)
    current_mah = mah(velocity, height)
    current_A = A(height)
    current_betta = betta(n_z_a, velocity, height, t) * 180 / 3.14159

    - interpolation_c_r_alpha_pr(current_mah) * (current_mah ** 2) * current_A * current_betta
end

def force_q(n_z_a, velocity, height, t)
    current_alpha_pr = alpha_pr(n_z_a, velocity, height, t)
    current_mah = mah(velocity, height)
    current_A = A(height)

    interpolation_c_x_a(current_mah, current_alpha_pr) * (current_mah ** 2) * current_A
end


# Законы управления

def dv_dt(n_z_a, velocity, height, t)
    (thrust(height, t) - force_q(n_z_a, velocity, height, t)) / current_mass(t)
end

def d_tetta_c_dt()
    0
end

def d_psi_dt(velocity, height, n_z_a)
    - (AtmosphereParameters.new(height).parameter_acceleration_free_fall * n_z_a) / velocity
end

def dx_c_dt(velocity, psi)
    velocity * Math.cos(psi)
end

def dz_c_dt(velocity, psi)
    - velocity * Math.sin(psi)
end

def issue_parameters(t, v, x, z, psi, n_z_a)
    h = Y_C_0
    current_mah = mah(v, h)
    current_alpha_pr = alpha_pr(n_z_a, v, h, t)

    [
        t, current_mass(t), thrust(h, t).round(2), v.round(3), current_mah.round(4), 
        interpolation_c_r_alpha_pr(current_mah), interpolation_c_x_a(current_mah, current_alpha_pr), alpha_pr(n_z_a, v, h, t).round(5),
        degrees(psi).round(5), x.round(2), z.round(2)
    ]
end

