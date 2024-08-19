CREATE TABLE `posts` (
	`slug` text PRIMARY KEY NOT NULL,
	`likes` integer DEFAULT 0,
	`views` integer DEFAULT 0,
	`created_at` text DEFAULT (CURRENT_DATE)
);
