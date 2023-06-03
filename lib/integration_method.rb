require_relative 'constants'
require_relative 'mathematical_model'

def runge_kutta()

    excel = ExcelData.new()
    dt = 0.01
    height = Y_C_0

    TABLE_N_Z_A.each do |n_z_a|

        puts n_z_a
        puts

        t = 0

        v_old = V_0
        v_new = V_0
        # tetta_c_old = TETTA_C_0
        # tetta_c_new = TETTA_C_0
        psi_new = PSI_0
        psi_old = PSI_0
        x_old = X_C_0
        x_new = X_C_0
        z_old = Z_C_0
        z_new = Z_C_0
        n = 0

        parameters = issue_parameters(t, v_new, x_new, z_new, psi_new, n_z_a)
        excel.create_line(parameters)

        while t <= T_AYT
            k_v_1 = dt * dv_dt(n_z_a, v_old, height, t)
            k_psi_1 = dt * d_psi_dt(v_old, height, n_z_a)
            k_x_1 = dt * dx_c_dt(v_old, psi_old)
            k_z_1 = dt * dz_c_dt(v_old, psi_old)

            k_v_2 = dt * dv_dt(n_z_a, v_old + k_v_1 / 2, height, t + dt / 2)
            k_psi_2 = dt * d_psi_dt(v_old + k_v_1 / 2, height, n_z_a)
            k_x_2 = dt * dx_c_dt(v_old + k_v_1 / 2, psi_old + k_psi_1 / 2)
            k_z_2 = dt * dz_c_dt(v_old + k_v_1 / 2, psi_old + k_psi_1 / 2)

            k_v_3 = dt * dv_dt(n_z_a, v_old + k_v_2 / 2, height, t + dt / 2)
            k_psi_3 = dt * d_psi_dt(v_old + k_v_2 / 2, height, n_z_a)
            k_x_3 = dt * dx_c_dt(v_old + k_v_2 / 2, psi_old + k_psi_2 / 2)
            k_z_3 = dt * dz_c_dt(v_old + k_v_2 / 2, psi_old + k_psi_2 / 2)

            k_v_4 = dt * dv_dt(n_z_a, v_old + k_v_3, height, t + dt)
            k_psi_4 = dt * d_psi_dt(v_old + k_v_3, height, n_z_a)
            k_x_4 = dt * dx_c_dt(v_old + k_v_3, psi_old + k_psi_3)
            k_z_4 = dt * dz_c_dt(v_old + k_v_3, psi_old + k_psi_3)


            v_new = v_old + (k_v_1 + 2* k_v_2 + 2 * k_v_3 + k_v_4) / 6
            psi_new = psi_old + (k_psi_1 + 2* k_psi_2 + 2 * k_psi_3 + k_psi_4) / 6
            x_new = x_old + (k_x_1 + 2* k_x_2 + 2 * k_x_3 + k_x_4) / 6
            z_new = z_old + (k_z_1 + 2* k_z_2 + 2 * k_z_3 + k_z_4) / 6

            v_old = v_new
            psi_old = psi_new
            x_old = x_new
            z_old = z_new

            t += dt
            t = t.round(3)

            if t % 0.5 == 0.0 or t == T_AYT
                n += 1
                parameters = issue_parameters(t, v_new, x_new, z_new, psi_new, n_z_a)
                excel.create_line(parameters)
            end
        end

        while v_old > V_MIN
            k_v_1 = dt * dv_dt(n_z_a, v_old, height, t)
            k_psi_1 = dt * d_psi_dt(v_old, height, n_z_a)
            k_x_1 = dt * dx_c_dt(v_old, psi_old)
            k_z_1 = dt * dz_c_dt(v_old, psi_old)

            k_v_2 = dt * dv_dt(n_z_a, v_old + k_v_1 / 2, height, t + dt / 2)
            k_psi_2 = dt * d_psi_dt(v_old + k_v_1 / 2, height, n_z_a)
            k_x_2 = dt * dx_c_dt(v_old + k_v_1 / 2, psi_old + k_psi_1 / 2)
            k_z_2 = dt * dz_c_dt(v_old + k_v_1 / 2, psi_old + k_psi_1 / 2)

            k_v_3 = dt * dv_dt(n_z_a, v_old + k_v_2 / 2, height, t + dt / 2)
            k_psi_3 = dt * d_psi_dt(v_old + k_v_2 / 2, height, n_z_a)
            k_x_3 = dt * dx_c_dt(v_old + k_v_2 / 2, psi_old + k_psi_2 / 2)
            k_z_3 = dt * dz_c_dt(v_old + k_v_2 / 2, psi_old + k_psi_2 / 2)

            k_v_4 = dt * dv_dt(n_z_a, v_old + k_v_3, height, t + dt)
            k_psi_4 = dt * d_psi_dt(v_old + k_v_3, height, n_z_a)
            k_x_4 = dt * dx_c_dt(v_old + k_v_3, psi_old + k_psi_3)
            k_z_4 = dt * dz_c_dt(v_old + k_v_3, psi_old + k_psi_3)


            v_new = v_old + (k_v_1 + 2* k_v_2 + 2 * k_v_3 + k_v_4) / 6
            psi_new = psi_old + (k_psi_1 + 2* k_psi_2 + 2 * k_psi_3 + k_psi_4) / 6
            x_new = x_old + (k_x_1 + 2* k_x_2 + 2 * k_x_3 + k_x_4) / 6
            z_new = z_old + (k_z_1 + 2* k_z_2 + 2 * k_z_3 + k_z_4) / 6

            v_old = v_new
            psi_old = psi_new
            x_old = x_new
            z_old = z_new

            t += dt
            t = t.round(3)

            if t % 1 == 0.0
                n += 1
                parameters = issue_parameters(t, v_new, x_new, z_new, psi_new, n_z_a)
                excel.create_line(parameters)
            end
        end

        v_old = V_MIN
        k_psi_1 = dt * d_psi_dt(v_old, height, n_z_a)
        k_x_1 = dt * dx_c_dt(v_old, psi_old)
        k_z_1 = dt * dz_c_dt(v_old, psi_old)

        k_psi_2 = dt * d_psi_dt(v_old, height, n_z_a)
        k_x_2 = dt * dx_c_dt(v_old, psi_old + k_psi_1 / 2)
        k_z_2 = dt * dz_c_dt(v_old, psi_old + k_psi_1 / 2)

        k_psi_3 = dt * d_psi_dt(v_old, height, n_z_a)
        k_x_3 = dt * dx_c_dt(v_old, psi_old + k_psi_2 / 2)
        k_z_3 = dt * dz_c_dt(v_old, psi_old + k_psi_2 / 2)

        k_psi_4 = dt * d_psi_dt(v_old, height, n_z_a)
        k_x_4 = dt * dx_c_dt(v_old, psi_old + k_psi_3)
        k_z_4 = dt * dz_c_dt(v_old, psi_old + k_psi_3)


        v_new = v_old
        psi_new = psi_old + (k_psi_1 + 2* k_psi_2 + 2 * k_psi_3 + k_psi_4) / 6
        x_new = x_old + (k_x_1 + 2* k_x_2 + 2 * k_x_3 + k_x_4) / 6
        z_new = z_old + (k_z_1 + 2* k_z_2 + 2 * k_z_3 + k_z_4) / 6

        t += dt
        t = t.round(3)

        n += 1
        parameters = issue_parameters(t, v_new, x_new, z_new, psi_new, n_z_a)
        excel.create_line(parameters)

        excel.create_sheet("При пер. #{n_z_a}")
        excel.clean
    end

    excel.save
end
