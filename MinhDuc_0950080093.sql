---bài 1
--a)Tạo login cho trưởng nhóm trưởng nhóm
CREATE LOGIN TruongNhom WITH PASSWORD = '1306';
GO
-- Tạo user cho trưởng nhóm trưởng nhóm
USE AdventureWorks2008R2;
CREATE USER TruongNhom FOR LOGIN TruongNhom;
GO
-- Tạo login cho nhân viên NV
CREATE LOGIN NhanVien WITH PASSWORD = '2306';
GO
-- Tạo user cho nhân viên NV
USE AdventureWorks2008R2;
CREATE USER NhanVien FOR LOGIN NhanVien;
GO
-- Tạo login cho nhân viên QuanLy
CREATE LOGIN QuanLy WITH PASSWORD = '2306';
GO
-- Tạo user cho nhân viên QL
USE AdventureWorks2008R2;
CREATE USER QuanLy FOR LOGIN QuanLy;
GO

--b. Phân quyền cho các nhân viên:
-- Phân quyền cho trưởng nhóm TN
USE AdventureWorks2008R2;
GRANT SELECT, UPDATE,DELETE ON Production.ProductInventory TO TruongNhom;
GO
-- Phân quyền cho nhân viên NV
USE AdventureWorks2008R2;
GRANT SELECT,UPDATE, DELETE ON Production.ProductInventory TO NhanVien;
GO
-- Phân quyền cho nhân viên QL
USE AdventureWorks2008R2;
GRANT SELECT ON Production.ProductInventory TO QuanLy;
GO
-- Admin phải có quyền CONTROL trên tất cả các đối tượng trong cơ sở dữ liệu
USE AdventureWorks2008R2;
GRANT CONTROL TO [Admin];
GO


-------d. Ai có thể sửa được dữ liệu bảng Production.Product ?
USE AdventureWorks2008R2;
SELECT * FROM fn_my_permissions('Production.ProductInventory', 'OBJECT') WHERE permission_name = 'UPDATE';

------e. Thu hồi quyền cấp cho nhân viên NV:
-- Thu hồi quyền của nhân viên NV
USE AdventureWorks2008R2;
REVOKE SELECT, DELETE ON Production.ProductInventory FROM NV;
GO
-- Xóa user của nhân viên NV
USE AdventureWorks2008R2;
DROP USER NV;
GO

-----bài 2
----1.
Restore full backup (T1)
---dùng lệnh 
RESTORE DATABASE AdventureWorks2008R2 FROM DISK = 'path_to_full_backup' WITH NORECOVERY;
----2. 
Apply differential backup 2 (T5)
---dùng lệnh 
RESTORE DATABASE AdventureWorks2008R2 FROM DISK = 'path_to_diff_backup_2' WITH NORECOVERY;
----3. 
Apply log backup (T7) 
---dùng lệnh 
RESTORE LOG AdventureWorks2008R2 FROM DISK = 'path_to_log_backup' WITH NORECOVERY;
----4. Kiểm tra xem DB phục hồi có ở trạng thái T7 không (Tới trạng thái trước khi xóa DB) 
--Nếu muốn phục hồi đến thời điểm T7, ta sử dụng lệnh 
STOPAT 'T7' 
--trong lệnh 
RESTORE LOG.
--Nếu muốn phục hồi đến thời điểm T9, ta sử dụng lệnh 
RECOVERY 
--thay vì 
WITH NORECOVERY 
--ở bước 3.