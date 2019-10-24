CREATE TABLE [dbo].[Restaurants] (
    [Id]       INT          IDENTITY (1, 1) NOT NULL,
    [name]     VARCHAR (50) NOT NULL,
    [location] VARCHAR (50) NOT NULL,
    [cuisine]  VARCHAR (50) NOT NULL,
    [rating]   FLOAT (53)   NOT NULL,
    [views]    INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

