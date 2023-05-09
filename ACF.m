% ham tu tuong quan
% r: Vector cac gia tri tuong quan cua khung

function [xx] = AFC(x)
    N = length(x);
    
    % Khởi tạo mảng để lưu giá trị của xx[n]
    xx = zeros(1, N);
    
    % Tính giá trị của xx[n]
    for n = 0:N-1
        for m = 0:N-1-n
            xx(n+1) = xx(n+1) + x(m+1) * x(m+n+1);
        end
    end  
    xx = xx/max(xx);
end
