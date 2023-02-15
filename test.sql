﻿CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "Activities" (
    "Id" uuid NOT NULL,
    "Title" text NULL,
    "Date" timestamp with time zone NOT NULL,
    "Description" text NULL,
    "Category" text NULL,
    "City" text NULL,
    "Venue" text NULL,
    "IsCancelled" boolean NOT NULL,
    CONSTRAINT "PK_Activities" PRIMARY KEY ("Id")
);

CREATE TABLE "AspNetRoles" (
    "Id" text NOT NULL,
    "Name" character varying(256) NULL,
    "NormalizedName" character varying(256) NULL,
    "ConcurrencyStamp" text NULL,
    CONSTRAINT "PK_AspNetRoles" PRIMARY KEY ("Id")
);

CREATE TABLE "AspNetUsers" (
    "Id" text NOT NULL,
    "DisplayName" text NULL,
    "Bio" text NULL,
    "UserName" character varying(256) NULL,
    "NormalizedUserName" character varying(256) NULL,
    "Email" character varying(256) NULL,
    "NormalizedEmail" character varying(256) NULL,
    "EmailConfirmed" boolean NOT NULL,
    "PasswordHash" text NULL,
    "SecurityStamp" text NULL,
    "ConcurrencyStamp" text NULL,
    "PhoneNumber" text NULL,
    "PhoneNumberConfirmed" boolean NOT NULL,
    "TwoFactorEnabled" boolean NOT NULL,
    "LockoutEnd" timestamp with time zone NULL,
    "LockoutEnabled" boolean NOT NULL,
    "AccessFailedCount" integer NOT NULL,
    CONSTRAINT "PK_AspNetUsers" PRIMARY KEY ("Id")
);

CREATE TABLE "AspNetRoleClaims" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "RoleId" text NOT NULL,
    "ClaimType" text NULL,
    "ClaimValue" text NULL,
    CONSTRAINT "PK_AspNetRoleClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_AspNetRoleClaims_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ActivitiesAtendees" (
    "AppUserId" text NOT NULL,
    "ActivityId" uuid NOT NULL,
    "IsHost" boolean NOT NULL,
    CONSTRAINT "PK_ActivitiesAtendees" PRIMARY KEY ("AppUserId", "ActivityId"),
    CONSTRAINT "FK_ActivitiesAtendees_Activities_ActivityId" FOREIGN KEY ("ActivityId") REFERENCES "Activities" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_ActivitiesAtendees_AspNetUsers_AppUserId" FOREIGN KEY ("AppUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserClaims" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "UserId" text NOT NULL,
    "ClaimType" text NULL,
    "ClaimValue" text NULL,
    CONSTRAINT "PK_AspNetUserClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_AspNetUserClaims_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserLogins" (
    "LoginProvider" text NOT NULL,
    "ProviderKey" text NOT NULL,
    "ProviderDisplayName" text NULL,
    "UserId" text NOT NULL,
    CONSTRAINT "PK_AspNetUserLogins" PRIMARY KEY ("LoginProvider", "ProviderKey"),
    CONSTRAINT "FK_AspNetUserLogins_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserRoles" (
    "UserId" text NOT NULL,
    "RoleId" text NOT NULL,
    CONSTRAINT "PK_AspNetUserRoles" PRIMARY KEY ("UserId", "RoleId"),
    CONSTRAINT "FK_AspNetUserRoles_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_AspNetUserRoles_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserTokens" (
    "UserId" text NOT NULL,
    "LoginProvider" text NOT NULL,
    "Name" text NOT NULL,
    "Value" text NULL,
    CONSTRAINT "PK_AspNetUserTokens" PRIMARY KEY ("UserId", "LoginProvider", "Name"),
    CONSTRAINT "FK_AspNetUserTokens_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "Comments" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "Body" text NULL,
    "AuthorId" text NULL,
    "ActivityId" uuid NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    CONSTRAINT "PK_Comments" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Comments_Activities_ActivityId" FOREIGN KEY ("ActivityId") REFERENCES "Activities" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_Comments_AspNetUsers_AuthorId" FOREIGN KEY ("AuthorId") REFERENCES "AspNetUsers" ("Id")
);

CREATE TABLE "Photos" (
    "Id" text NOT NULL,
    "Url" text NULL,
    "IsMain" boolean NOT NULL,
    "AppUserId" text NULL,
    CONSTRAINT "PK_Photos" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Photos_AspNetUsers_AppUserId" FOREIGN KEY ("AppUserId") REFERENCES "AspNetUsers" ("Id")
);

CREATE TABLE "UserFollowings" (
    "ObserverId" text NOT NULL,
    "TargetId" text NOT NULL,
    CONSTRAINT "PK_UserFollowings" PRIMARY KEY ("ObserverId", "TargetId"),
    CONSTRAINT "FK_UserFollowings_AspNetUsers_ObserverId" FOREIGN KEY ("ObserverId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_UserFollowings_AspNetUsers_TargetId" FOREIGN KEY ("TargetId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ActivitiesAtendees_ActivityId" ON "ActivitiesAtendees" ("ActivityId");

CREATE INDEX "IX_AspNetRoleClaims_RoleId" ON "AspNetRoleClaims" ("RoleId");

CREATE UNIQUE INDEX "RoleNameIndex" ON "AspNetRoles" ("NormalizedName");

CREATE INDEX "IX_AspNetUserClaims_UserId" ON "AspNetUserClaims" ("UserId");

CREATE INDEX "IX_AspNetUserLogins_UserId" ON "AspNetUserLogins" ("UserId");

CREATE INDEX "IX_AspNetUserRoles_RoleId" ON "AspNetUserRoles" ("RoleId");

CREATE INDEX "EmailIndex" ON "AspNetUsers" ("NormalizedEmail");

CREATE UNIQUE INDEX "UserNameIndex" ON "AspNetUsers" ("NormalizedUserName");

CREATE INDEX "IX_Comments_ActivityId" ON "Comments" ("ActivityId");

CREATE INDEX "IX_Comments_AuthorId" ON "Comments" ("AuthorId");

CREATE INDEX "IX_Photos_AppUserId" ON "Photos" ("AppUserId");

CREATE INDEX "IX_UserFollowings_TargetId" ON "UserFollowings" ("TargetId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20230214162930_PostGresInitial', '7.0.2');

COMMIT;

