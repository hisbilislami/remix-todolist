-- CreateTable
CREATE TABLE "t_todo" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "t_todo_pkey" PRIMARY KEY ("id")
);
