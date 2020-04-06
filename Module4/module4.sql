create table DigitalMarketing(
OpportunityId int primary key Identity(1,1) not null,
ProspectId int not null,
DateRaised datetime ,
Likelihood bit not null,
Rating char(1) not null,
EstimatedClosingDate date not null,
EstimatedRevenue decimal(10,2) not null
);

create table Prospects(
ProspectId  int primary key Identity(1,1) not null,
ProspectName varchar(30) not null)

ALTER TABLE DigitalMarketing
ADD CONSTRAINT FK_ProspectId
FOREIGN KEY (ProspectId) REFERENCES Prospects(ProspectId);

ALTER TABLE DigitalMarketing
ADD CONSTRAINT df_dateraised DEFAULT GETDATE() for DateRaised;

ALTER TABLE digitalMarketing
ADD CONSTRAINT CHK_dateraised CHECK (DateRaised=GETDATE());

ALTER TABLE DigitalMarketing  
DROP CONSTRAINT FK_ProspectId   
GO

ALTER TABLE digitalMarketing
ADD CONSTRAINT fk_ProspectId
    FOREIGN KEY (ProspectId)
    REFERENCES Prospects(ProspectId)
    ON DELETE CASCADE;