function [ty_rc, te_rc,finError] = data_an_red_ball_kalman

finError = [];
Qfact = 0.0001;
for Rfact = 0:0.1:1
    [ty_rc, te_rc, error_in_ty_te] = test_red_ball_Kalman(Rfact, Qfact)
    finError = [[finError];error_in_ty_te];
end
o=0;