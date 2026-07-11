% lattice structure
function [f_pt1, b_pt1] =lattice_struct(k_pt1, f, b)
b = circshift(b, 1);
b(1) =0;

f_pt1 = f - k_pt1 * b;
b_pt1 = b - k_pt1 * f;
end