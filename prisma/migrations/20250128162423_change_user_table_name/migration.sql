/*
  Warnings:

  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_created_by_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_updated_by_fkey";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "m_users" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT,
    "password" TEXT NOT NULL,
    "verified" BOOLEAN NOT NULL DEFAULT false,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" INTEGER,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by" INTEGER,

    CONSTRAINT "m_users_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "m_users_email_key" ON "m_users"("email");

-- AddForeignKey
ALTER TABLE "m_users" ADD CONSTRAINT "m_users_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "m_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "m_users" ADD CONSTRAINT "m_users_updated_by_fkey" FOREIGN KEY ("updated_by") REFERENCES "m_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
