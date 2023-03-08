c. Đăng nhập và thực hiện các yêu cầu:
--- Đăng nhập với tài khoản của nhân viên QL
USE AdventureWorks2008R2;
EXECUTE AS USER = 'QL';

-- Xem lại kết quả thực hiện của trưởng nhóm TN và nhân viên NV
SELECT * FROM Production.ProductInventory;

-- Kết thúc quyền của nhân viên QL
REVERT;
