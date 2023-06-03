require_relative 'constants'
require_relative 'mathematical_model'

# Метод линейной интерполяции
def line_interpolation(x, x_data, y_data)
    n = x_data.size - 1
    if n == 1
      a1 = (y_data[1] - y_data[0]) / (x_data[1] - x_data[0])
      a0 = y_data[0] - a1 * x_data[0]
      a0 + a1 * x
    else
      (0...n).each do |index|
        if (x_data[index]..x_data[index + 1]).include?(x)
          a1 = (y_data[index + 1] - y_data[index]) / (x_data[index + 1] - x_data[index])
          a0 = y_data[index] - a1 * x_data[index]
          return a0 + a1 * x
        end
      end
    end
end

def interpolation_c_r_alpha_pr(mah)
    line_interpolation(mah, TABLE_M, TABLE_C_R_ALPHA_PR)
end

def interpolation_c_x_a(current_mah, alpha_pr)
	c_m_1_4 = line_interpolation(alpha_pr, TABLE_ALPHA_PR, TABLE_C_XA_M_1_4)
	c_m_5_0 = line_interpolation(alpha_pr, TABLE_ALPHA_PR, TABLE_C_XA_M_5_0)

	(c_m_5_0 * (current_mah - 1.4) + c_m_1_4 * (5.0 - current_mah)) / (5.0 - 1.4)
end

