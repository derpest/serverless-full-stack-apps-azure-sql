ALTER DATABASE SCOPED CREDENTIAL AzureBlobCredentials
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
SECRET = 'sp=r&st=2021-03-12T00:47:24Z&se=2025-03-11T07:47:24Z&spr=https&sv=2020-02-10&sr=c&sig=BmuxFevKhWgbvo%2Bj8TlLYObjbB7gbvWzQaAgvGcg50c%3D';
DROP EXTERNAL DATA SOURCE RouteData;
CREATE EXTERNAL DATA SOURCE RouteData
WITH (
    TYPE = blob_storage,
    LOCATION = 'https://azuresqlworkshopsa.blob.core.windows.net/bus',
    CREDENTIAL = AzureBlobCredentials
);
DELETE FROM dbo.[Routes];
INSERT INTO dbo.[Routes]
([Id], [AgencyId], [ShortName], [Description], [Type])
SELECT 
[Id], [AgencyId], [ShortName], [Description], [Type]
FROM
openrowset
(
    bulk 'routes.txt', 
    data_source = 'RouteData', 
    formatfile = 'routes.fmt', 
    formatfile_data_source = 'RouteData', 
    firstrow=2,
    format='csv'
) t;
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;
INSERT INTO dbo.[GeoFences] 
    ([Name], [GeoFence]) 
VALUES
    ('Crossroads', 0xE6100000010407000000B4A78EA822CF4740E8D7539530895EC03837D51CEACE4740E80BFBE630895EC0ECD7DF53EACE4740E81B2C50F0885EC020389F0D03CF4740E99BD2A1F0885EC00CB8BEB203CF4740E9DB04FC23895EC068C132B920CF4740E9DB04FC23895EC0B4A78EA822CF4740E8D7539530895EC001000000020000000001000000FFFFFFFF0000000003);
INSERT INTO dbo.[MonitoredRoutes] (RouteId) VALUES (100113);
GO