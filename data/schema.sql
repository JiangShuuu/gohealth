-- 1. 首先建立不依賴其他表格的基礎表格
create database if not exists midTermDB;
use midTermDB;

-- 通用類型表
create table CommonType (
    commontype_id int auto_increment primary key,
    code_name varchar(50) not null,
    code_type varchar(50) not null,
    code_desc varchar(100) not null
);

-- 會員表
CREATE TABLE Members (
    member_id int auto_increment primary key,
    member_name varchar(50) not null,
    member_email varchar(100) not null unique,
    member_password varchar(100) not null,
    member_phone varchar(20),
    member_address varchar(200),
    member_birth date,
    member_img varchar(100),
    member_status int default 1,
    member_created datetime default current_timestamp
);

-- 產品類型表
create table ProductTypes(
    productType_id int auto_increment primary key,
    productType_name varchar(50) not null,
    productType_desc varchar(200)
);

-- 設施特色表
CREATE TABLE Features (
    feature_id int auto_increment primary key,
    feature_name varchar(50) not null
);

-- 健身房表
CREATE TABLE Gyms (
    gym_id int auto_increment primary key,
    gym_name varchar(100) not null,
    gym_address varchar(200) not null,
    gym_phone varchar(20) not null,
    gym_email varchar(100),
    gym_description text,
    gym_website varchar(200),
    gym_open_time time,
    gym_close_time time,
    gym_lat decimal(10,8),
    gym_lng decimal(11,8)
);

-- 教練圖片表
CREATE TABLE CoachImgs (
    coachImg_id int auto_increment primary key,
    coach_img varchar(100) not null
);

-- 課程圖片表
CREATE TABLE LessonImgs(
    LessonImgs_id int auto_increment primary key,
    lesson_img varchar(100) not null
);

-- 2. 然後建立依賴上述表格的表格
-- 健身房圖片表
CREATE TABLE GymImages (
    gym_image_id int auto_increment primary key,
    gym_id int not null,
    gym_image_path varchar(200) not null,
    foreign key (gym_id) references Gyms(gym_id)
);

-- 健身房設施關聯表
CREATE TABLE GymFeatures (
    gym_feature_id int auto_increment primary key,
    gym_id int not null,
    feature_id int not null,
    foreign key (gym_id) references Gyms(gym_id),
    foreign key (feature_id) references Features(feature_id)
);

-- 健身房預約表
CREATE TABLE GymReservations (
    reservation_id int auto_increment primary key,
    gym_id int not null,
    member_id int not null,
    reservation_date date not null,
    reservation_time time not null,
    reservation_status int default 1,
    foreign key (gym_id) references Gyms(gym_id),
    foreign key (member_id) references Members(member_id)
);

-- 教練表
CREATE TABLE Coaches (
    coach_id int auto_increment primary key,
    coach_name varchar(50) not null,
    coach_phone varchar(20),
    coach_email varchar(100),
    coach_description text,
    coach_img_id int,
    gym_id int,
    foreign key (coach_img_id) references CoachImgs(coachImg_id),
    foreign key (gym_id) references Gyms(gym_id)
);

-- 3. 最後建立依賴多個表格的表格
-- 教練技能表
CREATE TABLE CoachSkills (
    coach_skill_id int auto_increment primary key,
    coach_id int not null,
    commontype_id int not null,
    foreign key (coach_id) references Coaches(coach_id),
    foreign key (commontype_id) references CommonType(commontype_id)
);

-- 課程表
CREATE TABLE Lessons (
    lesson_id int auto_increment primary key,
    lesson_name varchar(100) not null,
    lesson_description text,
    lesson_price decimal(10,2) not null,
    lesson_date date,
    lesson_time time,
    lesson_duration int,
    coach_id int,
    gym_id int,
    LessonImgs_id int,
    foreign key (coach_id) references Coaches(coach_id),
    foreign key (gym_id) references Gyms(gym_id),
    foreign key (LessonImgs_id) references LessonImgs(LessonImgs_id)
);

-- 課程分類表
CREATE TABLE LessonCategories (
    lesson_category_id int auto_increment primary key,
    lesson_id int not null,
    commontype_id int not null,
    foreign key (lesson_id) references Lessons(lesson_id),
    foreign key (commontype_id) references CommonType(commontype_id)
);

-- 收藏教練表
CREATE TABLE FavCoach (
    fav_coach_id int auto_increment primary key,
    member_id int not null,
    coach_id int not null,
    foreign key (member_id) references Members(member_id),
    foreign key (coach_id) references Coaches(coach_id)
);

-- 收藏課程表
CREATE TABLE FavLesson (
    fav_lesson_id int auto_increment primary key,
    member_id int not null,
    lesson_id int not null,
    foreign key (member_id) references Members(member_id),
    foreign key (lesson_id) references Lessons(lesson_id)
);

-- 課程訂單表
CREATE TABLE LessonOrders (
    order_id int auto_increment primary key,
    member_id int not null,
    lesson_id int not null,
    order_date datetime default current_timestamp,
    order_status int default 1,
    foreign key (member_id) references Members(member_id),
    foreign key (lesson_id) references Lessons(lesson_id)
);

-- 教練預約表
CREATE TABLE coachReserve (
    coachReserve_id int auto_increment primary key,
    member_id int not null,
    coach_id int not null,
    reserve_date date not null,
    reserve_time time not null,
    reserve_status int default 1,
    foreign key (member_id) references Members(member_id),
    foreign key (coach_id) references Coaches(coach_id)
);

-- 收藏健身房表
CREATE TABLE FavGyms (
    fav_gym_id int auto_increment primary key,
    member_id int not null,
    gym_id int not null,
    foreign key (member_id) references Members(member_id),
    foreign key (gym_id) references Gyms(gym_id)
);