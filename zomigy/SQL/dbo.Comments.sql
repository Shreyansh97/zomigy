CREATE TABLE [dbo].[Comments] (
    [Id]         INT          IDENTITY (1, 1) NOT NULL,
    [Restaurant] INT          NOT NULL,
    [User]       INT          NOT NULL,
    [Text]       TEXT         NOT NULL,
    [Status]     VARCHAR (50) NOT NULL,
    [Timestamp]  DATETIME     DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC), 
    CONSTRAINT [FK_Comments_Restaurant] FOREIGN KEY ([Restaurant]) REFERENCES [Restaurants]([Id]), 
    CONSTRAINT [FK_Comments_Users] FOREIGN KEY ([User]) REFERENCES [Users]([Id]) 
);

