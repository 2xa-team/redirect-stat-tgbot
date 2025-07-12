CREATE TABLE "bot_settings"(
    "id" SERIAL NOT NULL,
    "data" jsonb NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "bot_settings" ADD PRIMARY KEY("id");
CREATE TABLE "reply_msgs"(
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "comment" TEXT NOT NULL,
    "content" jsonb NOT NULL,
    "disabled" BOOLEAN NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "reply_msgs" ADD PRIMARY KEY("id");
ALTER TABLE
    "reply_msgs" ADD CONSTRAINT "reply_msgs_name_unique" UNIQUE("name");
CREATE TABLE "deeplink_msgs"(
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "comment" TEXT NOT NULL,
    "content" jsonb NOT NULL,
    "disabled" BOOLEAN NOT NULL,
    "is_url_encoded" BOOLEAN NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "deeplink_msgs" ADD PRIMARY KEY("id");
ALTER TABLE
    "deeplink_msgs" ADD CONSTRAINT "deeplink_msgs_name_unique" UNIQUE("name");
CREATE TABLE "reply_stats"(
    "id" SERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "reply_msg_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP());
ALTER TABLE
    "reply_stats" ADD PRIMARY KEY("id");
CREATE INDEX "reply_stats_user_id_index" ON
    "reply_stats"("user_id");
CREATE INDEX "reply_stats_reply_msg_id_index" ON
    "reply_stats"("reply_msg_id");
CREATE TABLE "deeplink_stats"(
    "id" SERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "deeplink_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "deeplink_stats" ADD PRIMARY KEY("id");
CREATE INDEX "deeplink_stats_user_id_index" ON
    "deeplink_stats"("user_id");
CREATE INDEX "deeplink_stats_deeplink_id_index" ON
    "deeplink_stats"("deeplink_id");
CREATE TABLE "groups"(
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "comment" TEXT NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "groups" ADD PRIMARY KEY("id");
ALTER TABLE
    "groups" ADD CONSTRAINT "groups_name_unique" UNIQUE("name");
CREATE TABLE "group_contents"(
    "id" SERIAL NOT NULL,
    "group_id" INTEGER NOT NULL,
    "start_msg_id" INTEGER NULL,
    "reply_msg_id" INTEGER NULL,
    "deeplink_id" INTEGER NULL
);
ALTER TABLE
    "group_contents" ADD PRIMARY KEY("id");
CREATE INDEX "group_contents_group_id_index" ON
    "group_contents"("group_id");
CREATE INDEX "group_contents_start_msg_id_index" ON
    "group_contents"("start_msg_id");
CREATE INDEX "group_contents_reply_msg_id_index" ON
    "group_contents"("reply_msg_id");
CREATE INDEX "group_contents_deeplink_id_index" ON
    "group_contents"("deeplink_id");
CREATE TABLE "start_msgs"(
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "comment" TEXT NOT NULL,
    "content" jsonb NOT NULL,
    "disabled" BOOLEAN NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "start_msgs" ADD PRIMARY KEY("id");
ALTER TABLE
    "start_msgs" ADD CONSTRAINT "start_msgs_name_unique" UNIQUE("name");
CREATE TABLE "start_stats"(
    "id" SERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "start_msg_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP());
ALTER TABLE
    "start_stats" ADD PRIMARY KEY("id");
CREATE INDEX "start_stats_user_id_index" ON
    "start_stats"("user_id");
CREATE INDEX "start_stats_start_msg_id_index" ON
    "start_stats"("start_msg_id");
ALTER TABLE
    "deeplink_stats" ADD CONSTRAINT "deeplink_stats_deeplink_id_foreign" FOREIGN KEY("deeplink_id") REFERENCES "deeplink_msgs"("id");
ALTER TABLE
    "reply_stats" ADD CONSTRAINT "reply_stats_reply_msg_id_foreign" FOREIGN KEY("reply_msg_id") REFERENCES "reply_msgs"("id");
ALTER TABLE
    "start_stats" ADD CONSTRAINT "start_stats_start_msg_id_foreign" FOREIGN KEY("start_msg_id") REFERENCES "start_msgs"("id");
ALTER TABLE
    "group_contents" ADD CONSTRAINT "group_contents_start_msg_id_foreign" FOREIGN KEY("start_msg_id") REFERENCES "start_msgs"("id");
ALTER TABLE
    "group_contents" ADD CONSTRAINT "group_contents_reply_msg_id_foreign" FOREIGN KEY("reply_msg_id") REFERENCES "reply_msgs"("id");
ALTER TABLE
    "group_contents" ADD CONSTRAINT "group_contents_deeplink_id_foreign" FOREIGN KEY("deeplink_id") REFERENCES "deeplink_msgs"("id");
ALTER TABLE
    "group_contents" ADD CONSTRAINT "group_contents_group_id_foreign" FOREIGN KEY("group_id") REFERENCES "groups"("id");