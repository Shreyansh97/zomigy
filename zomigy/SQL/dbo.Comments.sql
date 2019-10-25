CREATE TABLE [dbo].[Comments] (
    [Id]         INT          IDENTITY (1, 1) NOT NULL,
    [Restaurant] INT          NOT NULL,
    [User]       INT          NOT NULL,
    [Text]       TEXT         NOT NULL,
    [Status]     VARCHAR (50) NOT NULL,
    [Timestamp]  DATETIME     DEFAULT (getdate()) NOT NULL,
    [rating]     INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Comments_Restaurant] FOREIGN KEY ([Restaurant]) REFERENCES [dbo].[Restaurants] ([Id]),
    CONSTRAINT [FK_Comments_Users] FOREIGN KEY ([User]) REFERENCES [dbo].[Users] ([Id])
);


GO

CREATE TRIGGER [dbo].[Update]
    ON [dbo].[Comments]
    FOR INSERT, UPDATE
    AS
    BEGIN
        SET NoCount ON
		UPDATE Restaurants SET rating = (SELECT ISNULL(AVG(rating),0) FROM Comments WHERE Restaurant = Restaurants.Id AND Status='approved');
    END