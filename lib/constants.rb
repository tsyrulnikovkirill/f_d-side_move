require_relative 'atmosphere_parameters'

def to_radian(angle)
    angle / 180.0 * Math::PI
end
  
def degrees(angle)
    angle / Math::PI * 180
end

# Переменные варианта
Y_C_0 = 5100                # начальная высота полёта
MASS_0 = 125                # начальная масса ЛА
D_MASS_DT = 16              # массовый расход в сек
S_M = 0.421                 # характерная площадь
V_0 = 709                   # начальная скорость ЛА

# Глобальные переменные
P_0 = 25000                 # тяга двигателя на поверхности Земли
S_A = 0.14                  # площадь критического сечения сопла
P_0_N = 101325              # атмосферное давление у поверхности Земли
T_AYT = 2.14                # время работы двигателя
T_0 = 0
TETTA_C_0 = 0
PSI_0 = 0
X_C_0 = 0
Z_C_0 = 0

# Условие окончания ПУТа
V_MIN = 1.38 * AtmosphereParameters.new(Y_C_0).parameter_sound_velocity

# Табличные значения маха и коэффицентов
TABLE_M = [1, 1.38, 1.4, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 6.0]
TABLE_C_R_ALPHA_PR = [0.0391, 0.0391, 0.0391, 0.0345, 0.0306, 0.0276, 0.0254, 0.0236, 0.0224, 0.0216, 0.0210]

TABLE_ALPHA_PR = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0]
TABLE_C_XA_M_1_4 = [0.0462, 0.0478, 0.05, 0.0525, 0.0573, 0.062, 0.0697, 0.077, 0.0867, 0.0956, 0.1069, 0.1183, 0.1268, 0.1397, 0.1533, 0.1678, 0.183, 0.1989, 0.2145, 0.2367]
TABLE_C_XA_M_5_0 = [0.031, 0.032, 0.033, 0.035, 0.038, 0.041, 0.044, 0.049, 0.054, 0.06, 0.066, 0.0745, 0.0819, 0.0913, 0.1018, 0.1131, 0.1251, 0.1379, 0.154, 0.1835]

# Значение перегрузок для графиков
TABLE_N_Z_A = [0, -3, 3, -6, 6, -9, 9, -12, 12, -15, 15] 
