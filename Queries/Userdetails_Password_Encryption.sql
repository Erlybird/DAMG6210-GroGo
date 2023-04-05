-- Passwored Encryption


USE GROUP14_DMDD_TEST;

-- Create DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Test_P@sswOrd';
-- Create certificate to protect symmetric key
CREATE CERTIFICATE TestCertificate
WITH SUBJECT = 'AdventureWorks Test Certificate',
EXPIRY_DATE = '2026-10-31';
-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY TestSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE TestCertificate;
-- Open symmetric key
OPEN SYMMETRIC KEY TestSymmetricKey
DECRYPTION BY CERTIFICATE TestCertificate;
-- Create a demo table
-- Use VARBINARY as the data type for the encrypted column
create table UserDetails
(
UserName VARCHAR(100) Primary Key,
EncryptedPassword VARBINARY(250),
PersonID int ,
FOREIGN KEY (PersonID) REFERENCES Person(PersonID));

-- INSERTING SAMPLE DATA
-- Use CONVERT to convert the plain data to VARBINARY


INSERT
INTO UserDetails
(
UserName,
EncryptedPassword,
PersonID
)
VALUES
('User 1' , EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'PassTS1')),1),
('jane_doe' , EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'PassTS2')),2),
('bob_smith' , EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'PassTS3')),3),
('sally_jones' , EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'PassTS4')),4),
('david_lee' , EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'PassTS5')),5),
('emily_kim' , EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'PassTS6')),6),
('chris_nguyen' , EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'PassTS7')),7),
('jamie_garcia' , EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'PassTS8')),8);




select * from UserDetails;


/*Decryption

-- Use DecryptByKey to decrypt the encrypted data and see what we have in the table
-- DecryptByKey returns VARBINARY with a maximum size of 8,000 bytes
-- Also use CONVERT to convert the decrypted data to VARCHAR so that we can see the
--plain passwords
select username, convert(varchar, DecryptByKey(EncryptedPassword)),PersonID
from UserDetails;
*/

/*
-- Close the symmetric key
CLOSE SYMMETRIC KEY TestSymmetricKey;
-- Drop the symmetric key
DROP SYMMETRIC KEY TestSymmetricKey;
-- Drop the certificate
DROP CERTIFICATE TestCertificate;
--Drop the DMK
DROP MASTER KEY;
USE Master;
*/
