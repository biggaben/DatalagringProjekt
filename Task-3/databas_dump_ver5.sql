PGDMP      ,                {            soundgood_ver_4    16.1    16.0 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16622    soundgood_ver_4    DATABASE     �   CREATE DATABASE soundgood_ver_4 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';
    DROP DATABASE soundgood_ver_4;
                postgres    false            �            1259    16675    booking    TABLE     �   CREATE TABLE public.booking (
    booking_id integer NOT NULL,
    instructor_id integer NOT NULL,
    start_time timestamp(0) without time zone,
    end_time timestamp(0) without time zone
);
    DROP TABLE public.booking;
       public         heap    postgres    false            �            1259    16674    booking_booking_id_seq    SEQUENCE     �   CREATE SEQUENCE public.booking_booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.booking_booking_id_seq;
       public          postgres    false    228            �           0    0    booking_booking_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.booking_booking_id_seq OWNED BY public.booking.booking_id;
          public          postgres    false    227            �            1259    16683    booking_lesson    TABLE     i   CREATE TABLE public.booking_lesson (
    student_id integer NOT NULL,
    booking_id integer NOT NULL
);
 "   DROP TABLE public.booking_lesson;
       public         heap    postgres    false            �            1259    16682    booking_lesson_booking_id_seq    SEQUENCE     �   CREATE SEQUENCE public.booking_lesson_booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.booking_lesson_booking_id_seq;
       public          postgres    false    231            �           0    0    booking_lesson_booking_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.booking_lesson_booking_id_seq OWNED BY public.booking_lesson.booking_id;
          public          postgres    false    230            �            1259    16681    booking_lesson_student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.booking_lesson_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.booking_lesson_student_id_seq;
       public          postgres    false    231                        0    0    booking_lesson_student_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.booking_lesson_student_id_seq OWNED BY public.booking_lesson.student_id;
          public          postgres    false    229            �            1259    16623    contact    TABLE     �   CREATE TABLE public.contact (
    contact_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    relation character varying(50) NOT NULL,
    phone_number character varying(50) NOT NULL
);
    DROP TABLE public.contact;
       public         heap    postgres    false            �            1259    16691    ensamble    TABLE     �   CREATE TABLE public.ensamble (
    ensamble_id integer NOT NULL,
    booking_id integer,
    genre character varying(50),
    min_students integer,
    max_students integer
);
    DROP TABLE public.ensamble;
       public         heap    postgres    false            �            1259    16690    ensamble_ensamble_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ensamble_ensamble_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.ensamble_ensamble_id_seq;
       public          postgres    false    233                       0    0    ensamble_ensamble_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.ensamble_ensamble_id_seq OWNED BY public.ensamble.ensamble_id;
          public          postgres    false    232            �            1259    16870    ensambles_comming_week    VIEW     �  CREATE VIEW public.ensambles_comming_week AS
 SELECT to_char(b.start_time, 'Day'::text) AS day,
    e.genre,
        CASE
            WHEN ((e.max_students - count(bl.student_id)) <= 0) THEN 'No Seats'::text
            WHEN (((e.max_students - count(bl.student_id)) >= 1) AND ((e.max_students - count(bl.student_id)) <= 2)) THEN '1 or 2 Seats'::text
            ELSE 'Many Seats'::text
        END AS "No of Free Seats"
   FROM ((public.booking b
     JOIN public.ensamble e ON ((b.booking_id = e.booking_id)))
     LEFT JOIN public.booking_lesson bl ON ((e.booking_id = bl.booking_id)))
  WHERE ((b.start_time >= (CURRENT_DATE + ('1 day'::interval * (EXTRACT(dow FROM CURRENT_DATE))::double precision))) AND (b.start_time < ((CURRENT_DATE + ('1 day'::interval * (((7)::numeric - EXTRACT(dow FROM CURRENT_DATE)))::double precision)) + '7 days'::interval)))
  GROUP BY e.genre, b.start_time, e.max_students
  ORDER BY e.genre, (to_char(b.start_time, 'Day'::text));
 )   DROP VIEW public.ensambles_comming_week;
       public          postgres    false    228    231    231    233    233    233    228            �            1259    16889    ensambles_comming_week1    MATERIALIZED VIEW     �  CREATE MATERIALIZED VIEW public.ensambles_comming_week1 AS
 SELECT to_char(b.start_time, 'Day'::text) AS day,
    e.genre,
        CASE
            WHEN ((e.max_students - count(bl.student_id)) <= 0) THEN 'No Seats'::text
            WHEN (((e.max_students - count(bl.student_id)) >= 1) AND ((e.max_students - count(bl.student_id)) <= 2)) THEN '1 or 2 Seats'::text
            ELSE 'Many Seats'::text
        END AS "No of Free Seats"
   FROM ((public.booking b
     JOIN public.ensamble e ON ((b.booking_id = e.booking_id)))
     LEFT JOIN public.booking_lesson bl ON ((e.booking_id = bl.booking_id)))
  WHERE ((b.start_time >= (CURRENT_DATE + ('1 day'::interval * (EXTRACT(dow FROM CURRENT_DATE))::double precision))) AND (b.start_time < ((CURRENT_DATE + ('1 day'::interval * (((7)::numeric - EXTRACT(dow FROM CURRENT_DATE)))::double precision)) + '7 days'::interval)))
  GROUP BY e.genre, b.start_time, e.max_students
  ORDER BY e.genre, (to_char(b.start_time, 'Day'::text))
  WITH NO DATA;
 7   DROP MATERIALIZED VIEW public.ensambles_comming_week1;
       public         heap    postgres    false    228    228    231    231    233    233    233            �            1259    16698    group_lesson    TABLE     �   CREATE TABLE public.group_lesson (
    group_lesson_id integer NOT NULL,
    booking_id integer,
    instrument_id integer,
    min_students integer,
    max_students integer,
    skill_level character varying(50)
);
     DROP TABLE public.group_lesson;
       public         heap    postgres    false            �            1259    16697     group_lesson_group_lesson_id_seq    SEQUENCE     �   CREATE SEQUENCE public.group_lesson_group_lesson_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.group_lesson_group_lesson_id_seq;
       public          postgres    false    235                       0    0     group_lesson_group_lesson_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.group_lesson_group_lesson_id_seq OWNED BY public.group_lesson.group_lesson_id;
          public          postgres    false    234            �            1259    16629 
   instructor    TABLE     ;  CREATE TABLE public.instructor (
    instructor_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    person_number character varying(12) NOT NULL,
    street character varying(50),
    zip character varying(50),
    city character varying(50),
    ensamble boolean
);
    DROP TABLE public.instructor;
       public         heap    postgres    false            �            1259    16628    instructor_instructor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.instructor_instructor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.instructor_instructor_id_seq;
       public          postgres    false    217                       0    0    instructor_instructor_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.instructor_instructor_id_seq OWNED BY public.instructor.instructor_id;
          public          postgres    false    216            �            1259    16704    instructor_instrument    TABLE     v   CREATE TABLE public.instructor_instrument (
    instrument_id integer NOT NULL,
    instructor_id integer NOT NULL
);
 )   DROP TABLE public.instructor_instrument;
       public         heap    postgres    false            �            1259    16709    instructor_phone    TABLE     l   CREATE TABLE public.instructor_phone (
    phone_id integer NOT NULL,
    instructor_id integer NOT NULL
);
 $   DROP TABLE public.instructor_phone;
       public         heap    postgres    false            �            1259    16635 
   instrument    TABLE     �   CREATE TABLE public.instrument (
    instrument_id integer NOT NULL,
    instrument character varying(50),
    skill_level character varying(50)
);
    DROP TABLE public.instrument;
       public         heap    postgres    false            �            1259    16715    instrument_booking    TABLE     �   CREATE TABLE public.instrument_booking (
    instrument_booking_id integer NOT NULL,
    instrument_rental_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    delivery boolean
);
 &   DROP TABLE public.instrument_booking;
       public         heap    postgres    false            �            1259    16714 ,   instrument_booking_instrument_booking_id_seq    SEQUENCE     �   CREATE SEQUENCE public.instrument_booking_instrument_booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 C   DROP SEQUENCE public.instrument_booking_instrument_booking_id_seq;
       public          postgres    false    239                       0    0 ,   instrument_booking_instrument_booking_id_seq    SEQUENCE OWNED BY     }   ALTER SEQUENCE public.instrument_booking_instrument_booking_id_seq OWNED BY public.instrument_booking.instrument_booking_id;
          public          postgres    false    238            �            1259    16641    instrument_rental    TABLE     �   CREATE TABLE public.instrument_rental (
    instrument_rental_id integer NOT NULL,
    type character varying(50),
    brand character varying(50),
    price_per_month real,
    category character varying(50),
    available boolean,
    date date
);
 %   DROP TABLE public.instrument_rental;
       public         heap    postgres    false            �            1259    16640 *   instrument_rental_instrument_rental_id_seq    SEQUENCE     �   CREATE SEQUENCE public.instrument_rental_instrument_rental_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 A   DROP SEQUENCE public.instrument_rental_instrument_rental_id_seq;
       public          postgres    false    220                       0    0 *   instrument_rental_instrument_rental_id_seq    SEQUENCE OWNED BY     y   ALTER SEQUENCE public.instrument_rental_instrument_rental_id_seq OWNED BY public.instrument_rental.instrument_rental_id;
          public          postgres    false    219            �            1259    16875    list_instructor_id    VIEW     �   CREATE VIEW public.list_instructor_id AS
SELECT
    NULL::integer AS instructor_id,
    NULL::character varying(50) AS first_name,
    NULL::character varying(50) AS last_name,
    NULL::bigint AS no_of_lessons;
 %   DROP VIEW public.list_instructor_id;
       public          postgres    false            �            1259    16731    solo_lesson    TABLE     �   CREATE TABLE public.solo_lesson (
    solo_lession_id integer NOT NULL,
    booking_id integer,
    instrument_id integer,
    skill_level character varying(50)
);
    DROP TABLE public.solo_lesson;
       public         heap    postgres    false            �            1259    16880    month_lesson_year    VIEW     _  CREATE VIEW public.month_lesson_year AS
 SELECT
        CASE EXTRACT(month FROM b.start_time)
            WHEN 1 THEN 'Jan'::text
            WHEN 2 THEN 'Feb'::text
            WHEN 3 THEN 'Mars'::text
            WHEN 4 THEN 'April'::text
            WHEN 5 THEN 'Maj'::text
            WHEN 6 THEN 'Juni'::text
            WHEN 7 THEN 'Juli'::text
            WHEN 8 THEN 'Aug'::text
            WHEN 9 THEN 'Sep'::text
            WHEN 10 THEN 'Okt'::text
            WHEN 11 THEN 'Nov'::text
            WHEN 12 THEN 'Dec'::text
            ELSE NULL::text
        END AS month,
    count(b.booking_id) AS total_lessons,
    count(sl.solo_lession_id) AS solo_lessons,
    count(gl.group_lesson_id) AS group_lessons,
    count(e.ensamble_id) AS ensamble_lessons
   FROM (((public.booking b
     LEFT JOIN public.solo_lesson sl ON ((b.booking_id = sl.booking_id)))
     LEFT JOIN public.group_lesson gl ON ((b.booking_id = gl.booking_id)))
     LEFT JOIN public.ensamble e ON ((b.booking_id = e.booking_id)))
  WHERE (EXTRACT(year FROM b.start_time) = (2023)::numeric)
  GROUP BY (EXTRACT(month FROM b.start_time));
 $   DROP VIEW public.month_lesson_year;
       public          postgres    false    228    244    244    235    235    233    233    228            �            1259    16647    number    TABLE     g   CREATE TABLE public.number (
    number_id integer NOT NULL,
    phone_number character varying(50)
);
    DROP TABLE public.number;
       public         heap    postgres    false            �            1259    16652    phone    TABLE     e   CREATE TABLE public.phone (
    phone_id integer NOT NULL,
    phone_number character varying(50)
);
    DROP TABLE public.phone;
       public         heap    postgres    false            �            1259    16738    price    TABLE     F  CREATE TABLE public.price (
    price_id integer NOT NULL,
    lecture_price real,
    group_lecture_price real,
    beginner real,
    intermediate real,
    advanced real,
    sibling_discount real,
    ensamble_price real,
    date date,
    solo_lession_id integer,
    ensamble_id integer,
    group_lesson_id integer
);
    DROP TABLE public.price;
       public         heap    postgres    false            �            1259    16737    price_price_id_seq    SEQUENCE     �   CREATE SEQUENCE public.price_price_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.price_price_id_seq;
       public          postgres    false    246                       0    0    price_price_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.price_price_id_seq OWNED BY public.price.price_id;
          public          postgres    false    245            �            1259    16723    rental    TABLE     l   CREATE TABLE public.rental (
    student_id integer NOT NULL,
    instrument_booking_id integer NOT NULL
);
    DROP TABLE public.rental;
       public         heap    postgres    false            �            1259    16722     rental_instrument_booking_id_seq    SEQUENCE     �   CREATE SEQUENCE public.rental_instrument_booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.rental_instrument_booking_id_seq;
       public          postgres    false    242                       0    0     rental_instrument_booking_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.rental_instrument_booking_id_seq OWNED BY public.rental.instrument_booking_id;
          public          postgres    false    241            �            1259    16721    rental_student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.rental_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.rental_student_id_seq;
       public          postgres    false    242                       0    0    rental_student_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.rental_student_id_seq OWNED BY public.rental.student_id;
          public          postgres    false    240            �            1259    16854    sibling_group    TABLE     n   CREATE TABLE public.sibling_group (
    student_id integer NOT NULL,
    sibling_group_id integer NOT NULL
);
 !   DROP TABLE public.sibling_group;
       public         heap    postgres    false            �            1259    16730    solo_lesson_solo_lession_id_seq    SEQUENCE     �   CREATE SEQUENCE public.solo_lesson_solo_lession_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.solo_lesson_solo_lession_id_seq;
       public          postgres    false    244            	           0    0    solo_lesson_solo_lession_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.solo_lesson_solo_lession_id_seq OWNED BY public.solo_lesson.solo_lession_id;
          public          postgres    false    243            �            1259    16658    student    TABLE       CREATE TABLE public.student (
    student_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    person_number character varying(12) NOT NULL,
    street character varying(50),
    zip character varying(50),
    city character varying(50)
);
    DROP TABLE public.student;
       public         heap    postgres    false            �            1259    16664    student_contact    TABLE     j   CREATE TABLE public.student_contact (
    contact_id integer NOT NULL,
    student_id integer NOT NULL
);
 #   DROP TABLE public.student_contact;
       public         heap    postgres    false            �            1259    16669    student_number    TABLE     h   CREATE TABLE public.student_number (
    number_id integer NOT NULL,
    student_id integer NOT NULL
);
 "   DROP TABLE public.student_number;
       public         heap    postgres    false            �            1259    16885    student_siblings    VIEW     �  CREATE VIEW public.student_siblings AS
 SELECT no_of_siblings,
    count(*) AS no_of_students
   FROM ( SELECT s.student_id,
            count(DISTINCT sg.sibling_group_id) AS no_of_siblings
           FROM (public.student s
             LEFT JOIN public.sibling_group sg ON ((s.student_id = sg.student_id)))
          GROUP BY s.student_id) siblingcounts
  GROUP BY no_of_siblings
  ORDER BY no_of_siblings;
 #   DROP VIEW public.student_siblings;
       public          postgres    false    247    224    247            �            1259    16657    student_student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.student_student_id_seq;
       public          postgres    false    224            
           0    0    student_student_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.student_student_id_seq OWNED BY public.student.student_id;
          public          postgres    false    223            �           2604    16678    booking booking_id    DEFAULT     x   ALTER TABLE ONLY public.booking ALTER COLUMN booking_id SET DEFAULT nextval('public.booking_booking_id_seq'::regclass);
 A   ALTER TABLE public.booking ALTER COLUMN booking_id DROP DEFAULT;
       public          postgres    false    228    227    228            �           2604    16686    booking_lesson student_id    DEFAULT     �   ALTER TABLE ONLY public.booking_lesson ALTER COLUMN student_id SET DEFAULT nextval('public.booking_lesson_student_id_seq'::regclass);
 H   ALTER TABLE public.booking_lesson ALTER COLUMN student_id DROP DEFAULT;
       public          postgres    false    231    229    231            �           2604    16687    booking_lesson booking_id    DEFAULT     �   ALTER TABLE ONLY public.booking_lesson ALTER COLUMN booking_id SET DEFAULT nextval('public.booking_lesson_booking_id_seq'::regclass);
 H   ALTER TABLE public.booking_lesson ALTER COLUMN booking_id DROP DEFAULT;
       public          postgres    false    230    231    231            �           2604    16694    ensamble ensamble_id    DEFAULT     |   ALTER TABLE ONLY public.ensamble ALTER COLUMN ensamble_id SET DEFAULT nextval('public.ensamble_ensamble_id_seq'::regclass);
 C   ALTER TABLE public.ensamble ALTER COLUMN ensamble_id DROP DEFAULT;
       public          postgres    false    232    233    233            �           2604    16701    group_lesson group_lesson_id    DEFAULT     �   ALTER TABLE ONLY public.group_lesson ALTER COLUMN group_lesson_id SET DEFAULT nextval('public.group_lesson_group_lesson_id_seq'::regclass);
 K   ALTER TABLE public.group_lesson ALTER COLUMN group_lesson_id DROP DEFAULT;
       public          postgres    false    234    235    235            �           2604    16632    instructor instructor_id    DEFAULT     �   ALTER TABLE ONLY public.instructor ALTER COLUMN instructor_id SET DEFAULT nextval('public.instructor_instructor_id_seq'::regclass);
 G   ALTER TABLE public.instructor ALTER COLUMN instructor_id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    16718 (   instrument_booking instrument_booking_id    DEFAULT     �   ALTER TABLE ONLY public.instrument_booking ALTER COLUMN instrument_booking_id SET DEFAULT nextval('public.instrument_booking_instrument_booking_id_seq'::regclass);
 W   ALTER TABLE public.instrument_booking ALTER COLUMN instrument_booking_id DROP DEFAULT;
       public          postgres    false    239    238    239            �           2604    16644 &   instrument_rental instrument_rental_id    DEFAULT     �   ALTER TABLE ONLY public.instrument_rental ALTER COLUMN instrument_rental_id SET DEFAULT nextval('public.instrument_rental_instrument_rental_id_seq'::regclass);
 U   ALTER TABLE public.instrument_rental ALTER COLUMN instrument_rental_id DROP DEFAULT;
       public          postgres    false    220    219    220                       2604    16741    price price_id    DEFAULT     p   ALTER TABLE ONLY public.price ALTER COLUMN price_id SET DEFAULT nextval('public.price_price_id_seq'::regclass);
 =   ALTER TABLE public.price ALTER COLUMN price_id DROP DEFAULT;
       public          postgres    false    245    246    246            �           2604    16726    rental student_id    DEFAULT     v   ALTER TABLE ONLY public.rental ALTER COLUMN student_id SET DEFAULT nextval('public.rental_student_id_seq'::regclass);
 @   ALTER TABLE public.rental ALTER COLUMN student_id DROP DEFAULT;
       public          postgres    false    242    240    242            �           2604    16727    rental instrument_booking_id    DEFAULT     �   ALTER TABLE ONLY public.rental ALTER COLUMN instrument_booking_id SET DEFAULT nextval('public.rental_instrument_booking_id_seq'::regclass);
 K   ALTER TABLE public.rental ALTER COLUMN instrument_booking_id DROP DEFAULT;
       public          postgres    false    242    241    242                        2604    16734    solo_lesson solo_lession_id    DEFAULT     �   ALTER TABLE ONLY public.solo_lesson ALTER COLUMN solo_lession_id SET DEFAULT nextval('public.solo_lesson_solo_lession_id_seq'::regclass);
 J   ALTER TABLE public.solo_lesson ALTER COLUMN solo_lession_id DROP DEFAULT;
       public          postgres    false    243    244    244            �           2604    16661    student student_id    DEFAULT     x   ALTER TABLE ONLY public.student ALTER COLUMN student_id SET DEFAULT nextval('public.student_student_id_seq'::regclass);
 A   ALTER TABLE public.student ALTER COLUMN student_id DROP DEFAULT;
       public          postgres    false    223    224    224            �          0    16675    booking 
   TABLE DATA           R   COPY public.booking (booking_id, instructor_id, start_time, end_time) FROM stdin;
    public          postgres    false    228   ��       �          0    16683    booking_lesson 
   TABLE DATA           @   COPY public.booking_lesson (student_id, booking_id) FROM stdin;
    public          postgres    false    231   s�       �          0    16623    contact 
   TABLE DATA           \   COPY public.contact (contact_id, first_name, last_name, relation, phone_number) FROM stdin;
    public          postgres    false    215   ��       �          0    16691    ensamble 
   TABLE DATA           ^   COPY public.ensamble (ensamble_id, booking_id, genre, min_students, max_students) FROM stdin;
    public          postgres    false    233   �       �          0    16698    group_lesson 
   TABLE DATA           {   COPY public.group_lesson (group_lesson_id, booking_id, instrument_id, min_students, max_students, skill_level) FROM stdin;
    public          postgres    false    235   d�       �          0    16629 
   instructor 
   TABLE DATA           v   COPY public.instructor (instructor_id, first_name, last_name, person_number, street, zip, city, ensamble) FROM stdin;
    public          postgres    false    217   ��       �          0    16704    instructor_instrument 
   TABLE DATA           M   COPY public.instructor_instrument (instrument_id, instructor_id) FROM stdin;
    public          postgres    false    236   ��       �          0    16709    instructor_phone 
   TABLE DATA           C   COPY public.instructor_phone (phone_id, instructor_id) FROM stdin;
    public          postgres    false    237   ��       �          0    16635 
   instrument 
   TABLE DATA           L   COPY public.instrument (instrument_id, instrument, skill_level) FROM stdin;
    public          postgres    false    218   2�       �          0    16715    instrument_booking 
   TABLE DATA           y   COPY public.instrument_booking (instrument_booking_id, instrument_rental_id, start_date, end_date, delivery) FROM stdin;
    public          postgres    false    239   ��       �          0    16641    instrument_rental 
   TABLE DATA           z   COPY public.instrument_rental (instrument_rental_id, type, brand, price_per_month, category, available, date) FROM stdin;
    public          postgres    false    220   \�       �          0    16647    number 
   TABLE DATA           9   COPY public.number (number_id, phone_number) FROM stdin;
    public          postgres    false    221   �       �          0    16652    phone 
   TABLE DATA           7   COPY public.phone (phone_id, phone_number) FROM stdin;
    public          postgres    false    222   ��       �          0    16738    price 
   TABLE DATA           �   COPY public.price (price_id, lecture_price, group_lecture_price, beginner, intermediate, advanced, sibling_discount, ensamble_price, date, solo_lession_id, ensamble_id, group_lesson_id) FROM stdin;
    public          postgres    false    246   �       �          0    16723    rental 
   TABLE DATA           C   COPY public.rental (student_id, instrument_booking_id) FROM stdin;
    public          postgres    false    242   ,�       �          0    16854    sibling_group 
   TABLE DATA           E   COPY public.sibling_group (student_id, sibling_group_id) FROM stdin;
    public          postgres    false    247   w�       �          0    16731    solo_lesson 
   TABLE DATA           ^   COPY public.solo_lesson (solo_lession_id, booking_id, instrument_id, skill_level) FROM stdin;
    public          postgres    false    244   ��       �          0    16658    student 
   TABLE DATA           f   COPY public.student (student_id, first_name, last_name, person_number, street, zip, city) FROM stdin;
    public          postgres    false    224   /�       �          0    16664    student_contact 
   TABLE DATA           A   COPY public.student_contact (contact_id, student_id) FROM stdin;
    public          postgres    false    225   �       �          0    16669    student_number 
   TABLE DATA           ?   COPY public.student_number (number_id, student_id) FROM stdin;
    public          postgres    false    226   m�                  0    0    booking_booking_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.booking_booking_id_seq', 1, false);
          public          postgres    false    227                       0    0    booking_lesson_booking_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.booking_lesson_booking_id_seq', 1, false);
          public          postgres    false    230                       0    0    booking_lesson_student_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.booking_lesson_student_id_seq', 1, false);
          public          postgres    false    229                       0    0    ensamble_ensamble_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.ensamble_ensamble_id_seq', 1, false);
          public          postgres    false    232                       0    0     group_lesson_group_lesson_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.group_lesson_group_lesson_id_seq', 1, true);
          public          postgres    false    234                       0    0    instructor_instructor_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.instructor_instructor_id_seq', 1, false);
          public          postgres    false    216                       0    0 ,   instrument_booking_instrument_booking_id_seq    SEQUENCE SET     [   SELECT pg_catalog.setval('public.instrument_booking_instrument_booking_id_seq', 1, false);
          public          postgres    false    238                       0    0 *   instrument_rental_instrument_rental_id_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.instrument_rental_instrument_rental_id_seq', 1, false);
          public          postgres    false    219                       0    0    price_price_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.price_price_id_seq', 1, false);
          public          postgres    false    245                       0    0     rental_instrument_booking_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.rental_instrument_booking_id_seq', 1, false);
          public          postgres    false    241                       0    0    rental_student_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.rental_student_id_seq', 1, false);
          public          postgres    false    240                       0    0    solo_lesson_solo_lession_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.solo_lesson_solo_lession_id_seq', 1, false);
          public          postgres    false    243                       0    0    student_student_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.student_student_id_seq', 1, false);
          public          postgres    false    223                       2606    16680    booking pk_booking 
   CONSTRAINT     X   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT pk_booking PRIMARY KEY (booking_id);
 <   ALTER TABLE ONLY public.booking DROP CONSTRAINT pk_booking;
       public            postgres    false    228                       2606    16689     booking_lesson pk_booking_lesson 
   CONSTRAINT     r   ALTER TABLE ONLY public.booking_lesson
    ADD CONSTRAINT pk_booking_lesson PRIMARY KEY (student_id, booking_id);
 J   ALTER TABLE ONLY public.booking_lesson DROP CONSTRAINT pk_booking_lesson;
       public            postgres    false    231    231                       2606    16627    contact pk_contact 
   CONSTRAINT     X   ALTER TABLE ONLY public.contact
    ADD CONSTRAINT pk_contact PRIMARY KEY (contact_id);
 <   ALTER TABLE ONLY public.contact DROP CONSTRAINT pk_contact;
       public            postgres    false    215                       2606    16696    ensamble pk_ensamble 
   CONSTRAINT     [   ALTER TABLE ONLY public.ensamble
    ADD CONSTRAINT pk_ensamble PRIMARY KEY (ensamble_id);
 >   ALTER TABLE ONLY public.ensamble DROP CONSTRAINT pk_ensamble;
       public            postgres    false    233                       2606    16703    group_lesson pk_group_lesson 
   CONSTRAINT     g   ALTER TABLE ONLY public.group_lesson
    ADD CONSTRAINT pk_group_lesson PRIMARY KEY (group_lesson_id);
 F   ALTER TABLE ONLY public.group_lesson DROP CONSTRAINT pk_group_lesson;
       public            postgres    false    235                       2606    16634    instructor pk_instructor 
   CONSTRAINT     a   ALTER TABLE ONLY public.instructor
    ADD CONSTRAINT pk_instructor PRIMARY KEY (instructor_id);
 B   ALTER TABLE ONLY public.instructor DROP CONSTRAINT pk_instructor;
       public            postgres    false    217                       2606    16708 .   instructor_instrument pk_instructor_instrument 
   CONSTRAINT     �   ALTER TABLE ONLY public.instructor_instrument
    ADD CONSTRAINT pk_instructor_instrument PRIMARY KEY (instrument_id, instructor_id);
 X   ALTER TABLE ONLY public.instructor_instrument DROP CONSTRAINT pk_instructor_instrument;
       public            postgres    false    236    236                       2606    16713 $   instructor_phone pk_instructor_phone 
   CONSTRAINT     w   ALTER TABLE ONLY public.instructor_phone
    ADD CONSTRAINT pk_instructor_phone PRIMARY KEY (phone_id, instructor_id);
 N   ALTER TABLE ONLY public.instructor_phone DROP CONSTRAINT pk_instructor_phone;
       public            postgres    false    237    237                       2606    16639    instrument pk_instrument 
   CONSTRAINT     a   ALTER TABLE ONLY public.instrument
    ADD CONSTRAINT pk_instrument PRIMARY KEY (instrument_id);
 B   ALTER TABLE ONLY public.instrument DROP CONSTRAINT pk_instrument;
       public            postgres    false    218            !           2606    16720 (   instrument_booking pk_instrument_booking 
   CONSTRAINT     y   ALTER TABLE ONLY public.instrument_booking
    ADD CONSTRAINT pk_instrument_booking PRIMARY KEY (instrument_booking_id);
 R   ALTER TABLE ONLY public.instrument_booking DROP CONSTRAINT pk_instrument_booking;
       public            postgres    false    239            	           2606    16646 &   instrument_rental pk_instrument_rental 
   CONSTRAINT     v   ALTER TABLE ONLY public.instrument_rental
    ADD CONSTRAINT pk_instrument_rental PRIMARY KEY (instrument_rental_id);
 P   ALTER TABLE ONLY public.instrument_rental DROP CONSTRAINT pk_instrument_rental;
       public            postgres    false    220                       2606    16651    number pk_number 
   CONSTRAINT     U   ALTER TABLE ONLY public.number
    ADD CONSTRAINT pk_number PRIMARY KEY (number_id);
 :   ALTER TABLE ONLY public.number DROP CONSTRAINT pk_number;
       public            postgres    false    221                       2606    16656    phone pk_phone 
   CONSTRAINT     R   ALTER TABLE ONLY public.phone
    ADD CONSTRAINT pk_phone PRIMARY KEY (phone_id);
 8   ALTER TABLE ONLY public.phone DROP CONSTRAINT pk_phone;
       public            postgres    false    222            '           2606    16743    price pk_price 
   CONSTRAINT     R   ALTER TABLE ONLY public.price
    ADD CONSTRAINT pk_price PRIMARY KEY (price_id);
 8   ALTER TABLE ONLY public.price DROP CONSTRAINT pk_price;
       public            postgres    false    246            #           2606    16729    rental pk_rental 
   CONSTRAINT     m   ALTER TABLE ONLY public.rental
    ADD CONSTRAINT pk_rental PRIMARY KEY (student_id, instrument_booking_id);
 :   ALTER TABLE ONLY public.rental DROP CONSTRAINT pk_rental;
       public            postgres    false    242    242            )           2606    16858    sibling_group pk_sibling_group 
   CONSTRAINT     v   ALTER TABLE ONLY public.sibling_group
    ADD CONSTRAINT pk_sibling_group PRIMARY KEY (student_id, sibling_group_id);
 H   ALTER TABLE ONLY public.sibling_group DROP CONSTRAINT pk_sibling_group;
       public            postgres    false    247    247            %           2606    16736    solo_lesson pk_solo_lesson 
   CONSTRAINT     e   ALTER TABLE ONLY public.solo_lesson
    ADD CONSTRAINT pk_solo_lesson PRIMARY KEY (solo_lession_id);
 D   ALTER TABLE ONLY public.solo_lesson DROP CONSTRAINT pk_solo_lesson;
       public            postgres    false    244                       2606    16663    student pk_student 
   CONSTRAINT     X   ALTER TABLE ONLY public.student
    ADD CONSTRAINT pk_student PRIMARY KEY (student_id);
 <   ALTER TABLE ONLY public.student DROP CONSTRAINT pk_student;
       public            postgres    false    224                       2606    16668 "   student_contact pk_student_contact 
   CONSTRAINT     t   ALTER TABLE ONLY public.student_contact
    ADD CONSTRAINT pk_student_contact PRIMARY KEY (contact_id, student_id);
 L   ALTER TABLE ONLY public.student_contact DROP CONSTRAINT pk_student_contact;
       public            postgres    false    225    225                       2606    16673     student_number pk_student_number 
   CONSTRAINT     q   ALTER TABLE ONLY public.student_number
    ADD CONSTRAINT pk_student_number PRIMARY KEY (number_id, student_id);
 J   ALTER TABLE ONLY public.student_number DROP CONSTRAINT pk_student_number;
       public            postgres    false    226    226            �           2618    16878    list_instructor_id _RETURN    RULE     T  CREATE OR REPLACE VIEW public.list_instructor_id AS
 SELECT i.instructor_id,
    i.first_name,
    i.last_name,
    count(*) AS no_of_lessons
   FROM ((public.booking b
     JOIN public.instructor i ON ((b.instructor_id = i.instructor_id)))
     JOIN public.booking_lesson bl ON ((b.booking_id = bl.booking_id)))
  WHERE ((b.start_time >= date_trunc('month'::text, (CURRENT_DATE)::timestamp with time zone)) AND (b.end_time < (date_trunc('month'::text, (CURRENT_DATE)::timestamp with time zone) + '1 mon'::interval)))
  GROUP BY i.instructor_id
 HAVING (count(*) > 0)
  ORDER BY (count(*)) DESC;
 �   CREATE OR REPLACE VIEW public.list_instructor_id AS
SELECT
    NULL::integer AS instructor_id,
    NULL::character varying(50) AS first_name,
    NULL::character varying(50) AS last_name,
    NULL::bigint AS no_of_lessons;
       public          postgres    false    217    231    228    228    228    228    3589    217    217    249            .           2606    16764    booking fk_booking_0    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT fk_booking_0 FOREIGN KEY (instructor_id) REFERENCES public.instructor(instructor_id);
 >   ALTER TABLE ONLY public.booking DROP CONSTRAINT fk_booking_0;
       public          postgres    false    228    3589    217            /           2606    16769 "   booking_lesson fk_booking_lesson_0    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking_lesson
    ADD CONSTRAINT fk_booking_lesson_0 FOREIGN KEY (student_id) REFERENCES public.student(student_id);
 L   ALTER TABLE ONLY public.booking_lesson DROP CONSTRAINT fk_booking_lesson_0;
       public          postgres    false    3599    231    224            0           2606    16774 "   booking_lesson fk_booking_lesson_1    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking_lesson
    ADD CONSTRAINT fk_booking_lesson_1 FOREIGN KEY (booking_id) REFERENCES public.booking(booking_id);
 L   ALTER TABLE ONLY public.booking_lesson DROP CONSTRAINT fk_booking_lesson_1;
       public          postgres    false    231    3605    228            1           2606    16779    ensamble fk_ensamble_0    FK CONSTRAINT     �   ALTER TABLE ONLY public.ensamble
    ADD CONSTRAINT fk_ensamble_0 FOREIGN KEY (booking_id) REFERENCES public.booking(booking_id);
 @   ALTER TABLE ONLY public.ensamble DROP CONSTRAINT fk_ensamble_0;
       public          postgres    false    233    3605    228            2           2606    16784    group_lesson fk_group_lesson_0    FK CONSTRAINT     �   ALTER TABLE ONLY public.group_lesson
    ADD CONSTRAINT fk_group_lesson_0 FOREIGN KEY (booking_id) REFERENCES public.booking(booking_id);
 H   ALTER TABLE ONLY public.group_lesson DROP CONSTRAINT fk_group_lesson_0;
       public          postgres    false    3605    235    228            3           2606    16789    group_lesson fk_group_lesson_1    FK CONSTRAINT     �   ALTER TABLE ONLY public.group_lesson
    ADD CONSTRAINT fk_group_lesson_1 FOREIGN KEY (instrument_id) REFERENCES public.instrument(instrument_id);
 H   ALTER TABLE ONLY public.group_lesson DROP CONSTRAINT fk_group_lesson_1;
       public          postgres    false    235    218    3591            4           2606    16794 0   instructor_instrument fk_instructor_instrument_0    FK CONSTRAINT     �   ALTER TABLE ONLY public.instructor_instrument
    ADD CONSTRAINT fk_instructor_instrument_0 FOREIGN KEY (instrument_id) REFERENCES public.instrument(instrument_id);
 Z   ALTER TABLE ONLY public.instructor_instrument DROP CONSTRAINT fk_instructor_instrument_0;
       public          postgres    false    3591    236    218            5           2606    16799 0   instructor_instrument fk_instructor_instrument_1    FK CONSTRAINT     �   ALTER TABLE ONLY public.instructor_instrument
    ADD CONSTRAINT fk_instructor_instrument_1 FOREIGN KEY (instructor_id) REFERENCES public.instructor(instructor_id);
 Z   ALTER TABLE ONLY public.instructor_instrument DROP CONSTRAINT fk_instructor_instrument_1;
       public          postgres    false    236    217    3589            6           2606    16804 &   instructor_phone fk_instructor_phone_0    FK CONSTRAINT     �   ALTER TABLE ONLY public.instructor_phone
    ADD CONSTRAINT fk_instructor_phone_0 FOREIGN KEY (phone_id) REFERENCES public.phone(phone_id);
 P   ALTER TABLE ONLY public.instructor_phone DROP CONSTRAINT fk_instructor_phone_0;
       public          postgres    false    3597    237    222            7           2606    16809 &   instructor_phone fk_instructor_phone_1    FK CONSTRAINT     �   ALTER TABLE ONLY public.instructor_phone
    ADD CONSTRAINT fk_instructor_phone_1 FOREIGN KEY (instructor_id) REFERENCES public.instructor(instructor_id);
 P   ALTER TABLE ONLY public.instructor_phone DROP CONSTRAINT fk_instructor_phone_1;
       public          postgres    false    3589    237    217            8           2606    16814 *   instrument_booking fk_instrument_booking_0    FK CONSTRAINT     �   ALTER TABLE ONLY public.instrument_booking
    ADD CONSTRAINT fk_instrument_booking_0 FOREIGN KEY (instrument_rental_id) REFERENCES public.instrument_rental(instrument_rental_id);
 T   ALTER TABLE ONLY public.instrument_booking DROP CONSTRAINT fk_instrument_booking_0;
       public          postgres    false    220    3593    239            =           2606    16839    price fk_price_0    FK CONSTRAINT     �   ALTER TABLE ONLY public.price
    ADD CONSTRAINT fk_price_0 FOREIGN KEY (solo_lession_id) REFERENCES public.solo_lesson(solo_lession_id);
 :   ALTER TABLE ONLY public.price DROP CONSTRAINT fk_price_0;
       public          postgres    false    246    244    3621            >           2606    16844    price fk_price_1    FK CONSTRAINT        ALTER TABLE ONLY public.price
    ADD CONSTRAINT fk_price_1 FOREIGN KEY (ensamble_id) REFERENCES public.ensamble(ensamble_id);
 :   ALTER TABLE ONLY public.price DROP CONSTRAINT fk_price_1;
       public          postgres    false    246    233    3609            ?           2606    16849    price fk_price_2    FK CONSTRAINT     �   ALTER TABLE ONLY public.price
    ADD CONSTRAINT fk_price_2 FOREIGN KEY (group_lesson_id) REFERENCES public.group_lesson(group_lesson_id);
 :   ALTER TABLE ONLY public.price DROP CONSTRAINT fk_price_2;
       public          postgres    false    235    246    3611            9           2606    16819    rental fk_rental_0    FK CONSTRAINT     ~   ALTER TABLE ONLY public.rental
    ADD CONSTRAINT fk_rental_0 FOREIGN KEY (student_id) REFERENCES public.student(student_id);
 <   ALTER TABLE ONLY public.rental DROP CONSTRAINT fk_rental_0;
       public          postgres    false    242    3599    224            :           2606    16824    rental fk_rental_1    FK CONSTRAINT     �   ALTER TABLE ONLY public.rental
    ADD CONSTRAINT fk_rental_1 FOREIGN KEY (instrument_booking_id) REFERENCES public.instrument_booking(instrument_booking_id);
 <   ALTER TABLE ONLY public.rental DROP CONSTRAINT fk_rental_1;
       public          postgres    false    242    239    3617            @           2606    16860     sibling_group fk_sibling_group_0    FK CONSTRAINT     �   ALTER TABLE ONLY public.sibling_group
    ADD CONSTRAINT fk_sibling_group_0 FOREIGN KEY (student_id) REFERENCES public.student(student_id);
 J   ALTER TABLE ONLY public.sibling_group DROP CONSTRAINT fk_sibling_group_0;
       public          postgres    false    247    3599    224            A           2606    16865     sibling_group fk_sibling_group_1    FK CONSTRAINT     �   ALTER TABLE ONLY public.sibling_group
    ADD CONSTRAINT fk_sibling_group_1 FOREIGN KEY (sibling_group_id) REFERENCES public.student(student_id);
 J   ALTER TABLE ONLY public.sibling_group DROP CONSTRAINT fk_sibling_group_1;
       public          postgres    false    3599    224    247            ;           2606    16829    solo_lesson fk_solo_lesson_0    FK CONSTRAINT     �   ALTER TABLE ONLY public.solo_lesson
    ADD CONSTRAINT fk_solo_lesson_0 FOREIGN KEY (booking_id) REFERENCES public.booking(booking_id);
 F   ALTER TABLE ONLY public.solo_lesson DROP CONSTRAINT fk_solo_lesson_0;
       public          postgres    false    244    228    3605            <           2606    16834    solo_lesson fk_solo_lesson_1    FK CONSTRAINT     �   ALTER TABLE ONLY public.solo_lesson
    ADD CONSTRAINT fk_solo_lesson_1 FOREIGN KEY (instrument_id) REFERENCES public.instrument(instrument_id);
 F   ALTER TABLE ONLY public.solo_lesson DROP CONSTRAINT fk_solo_lesson_1;
       public          postgres    false    3591    218    244            *           2606    16744 $   student_contact fk_student_contact_0    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_contact
    ADD CONSTRAINT fk_student_contact_0 FOREIGN KEY (contact_id) REFERENCES public.contact(contact_id);
 N   ALTER TABLE ONLY public.student_contact DROP CONSTRAINT fk_student_contact_0;
       public          postgres    false    215    3587    225            +           2606    16749 $   student_contact fk_student_contact_1    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_contact
    ADD CONSTRAINT fk_student_contact_1 FOREIGN KEY (student_id) REFERENCES public.student(student_id);
 N   ALTER TABLE ONLY public.student_contact DROP CONSTRAINT fk_student_contact_1;
       public          postgres    false    224    225    3599            ,           2606    16754 "   student_number fk_student_number_0    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_number
    ADD CONSTRAINT fk_student_number_0 FOREIGN KEY (number_id) REFERENCES public.number(number_id);
 L   ALTER TABLE ONLY public.student_number DROP CONSTRAINT fk_student_number_0;
       public          postgres    false    226    3595    221            -           2606    16759 "   student_number fk_student_number_1    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_number
    ADD CONSTRAINT fk_student_number_1 FOREIGN KEY (student_id) REFERENCES public.student(student_id);
 L   ALTER TABLE ONLY public.student_number DROP CONSTRAINT fk_student_number_1;
       public          postgres    false    3599    224    226            �           0    16889    ensambles_comming_week1    MATERIALIZED VIEW DATA     :   REFRESH MATERIALIZED VIEW public.ensambles_comming_week1;
          public          postgres    false    252    3833            �   �   x�m�]1�g{
/�����Y��9,�ͲH��a&_Z ߖ] ȃx�;�h�K�_�@��@bB��BH�D�V�YL��^��E߂�vbd���z;1�Xa���"Ix��~���Bh{�e-ӿ�,�[���,\�(N�y�־��k�      �   Z   x�=���0�w�2	��.��� ���-��]PQ��A-j��q3j���Ew�ņ��]���\K��7���n������9s�zo� =a$�      �   !  x�]�KN�0���=�#gYD�D[��-�)q�q*;E�"��3p�\�X��>���X�a�=��k����%:�)��eU7���Up/нY��n�0��*F�T;a�|
��ÐUͨ%U����>'�kNj�2t�a6�{�,)�H�2�4�;.���L�D�ia5��8��;E�E?N9��:q)�!>��-��ESf\�F�,�ʴgD�?6�����eET���k7��kHg�?��ьj�*alOw^����=�ϘVҵj�Q�)����~c�K��D�漶x�*��6�|      �   F   x�%�1
�0����p�e��t)�0���p;��0ұ�3С� m���^Ԋ�d�(�"C��c�}����      �   '   x�3�4200�4300�4�44�LJM���K-����� `��      �   �  x�M�Mr�0���)xu�ii9�m�H<Yu�J��	EfH���r��Tdg#�� ��� �pŏb��QB�a�ER�U[)?�*V@�jໞ�Y���M��A�CG� u�fI�%<��É���XA��i<�qb;�N�Bo;�v�H��5�'����I��I��r�#�����)����+x�\��4�k�'cxOg���{$g����.(%\9\�f#G�%�I���~�|`%�]�����*�14�v��*�*VI�︵�ӳ�#7� �x�x���[C���l]�Xc�Ćݨ}�N�Ʊ��.�t���0.0��l|�6�$����س3D�5�lI�JXgD�����v�c�m�;�u��`�� �kFw|��"D�����i<�q�(�M1���l�q�{_�z�Xs]�P����	�j���.��4Y:f+��P
i��5��~<v����e�W\�w{���XoD��?r���m���(��B      �   E   x�ͱ� ��*��/@@/�뒛ͮ$?�%%J4�@M��B�
m��A]t[V�B<��<���$�      �   G   x�=ͱ� ��*��D/�s	��f���:���UG%�h�D��D�ڨ�,��0�p��n'      �   �   x�e�K�0C��)z�*釶w�f S:R��$ �_X��>Y�ve�C+�RBͭ�r2���B!Z8u�
/��Qb���a��J���Nq�'��
~N��LS�Qy�x���3^h%ѹr�q5�|j���V��:q���\��l��m�X�      �   v   x�M��� �sم*��g��;A�W�.Ȳ��`D�P<L,�J�X�dD�^���Z�象�.1b� �kQ(6*D�ϛ��F�h�ySplt����E���b��M�יRzG�6�      �   �  x�m��n�0E�W_�Uw-8���2q�H�p��@7#���ФAIM���$nc P �3�L��f�G|�w�Ra;D�b�V�|�(}E��ƃ��to�"t�A��%�,� ��O|)�[sj��W���ʍ��ׁV�B�d}{Y����qz����t�u����b�±�`k��DT��S�g����(�y�Iב����	7O\84Ru��ހs��
��3j�~�n�{�%�H,),�sY���NC���KJ`J���lne|�F+�.�H�j���wס�	ֳW�أk�G|:?y7Yv'L3kAb�*|n�y�|I�Q�U4~�M�!J#nH�To�#�GS܏cc#��3�x����Y�&�k�W3�5�@���������Z�3��@Z`þ}^�s�ZgX������3�MQ<2(SV��Ǉ�(�a_�`      �   �   x�EαC!C��������:�Ɓn�{�k�S>��{*<p�wh���?{�:���f�aVͪ�jV�U����Ueլ*+���̪�2��ʬ��Y)+�RVf���JY���2+euY)��JY]V���Z{����_JkP5      �   T   x�Eι�@C��������`E���@3�q�,tV�ip�c?�,�%7y�-�!/zʛ^�����8\N:��������f���%/      �      x������ � �      �   ;   x�ƹ�0��(����^��m�ᬧ�P8�6Y�Ŋm��yWf��l�����@      �   A   x�=��	�0�wTLX9��I�u��>ǰp	u%O���bٖM���iS�b��5T*Z��y�wD|-;      �   W   x�eͱ� Й~�)EA��Ebc:�@���v��].W�cDF4��wT�.p	֧�G/;��K�߬��}���{/��y�}��,�      �   �  x�]�[r�0E��Uh�P��g�ϼ���L�?���l)�(7�º�n� ��R����
�3!$�]cn�q}ߵ�r!�LeY�p��%�G��W;˄(���{3K
Q�2������V�uR����:��)+x��e/+˥�D��͋n�!��~XذC]!����j�-kjQ�u��28խI��{^���+*Vdp�l\L,iD�7)�co��i@�D	�{��I�����a���߲V	��4�ꆀZ��*d��n�ې����.&	AGOc���i�`'
E�>x�
$CV�zA�i,���	��"������cX#��_X�rX/5fW�֓����ݣ��[Q��5��������������.�~Ԅ^�gn�?�,������%�!�S
>��bbeM�Ƨ�<?z���bE�끅��ĲqeyC��Y��(	���c"2�O�[g�u	6������Զ8Z�Q�	
6�W:&Z������v��K��{&�Q~DBJ8��ع��e9��,:lh$؂"�Ӂ↋~���+
vL|ף=�F��\�C4�`D&)�2W�^'؋RS��>���}���`�\oLH��F^�\٠�?�\��`�.�D����L�����]ciM�v�7{�khj��X����s��8�=~�KA�)�oI�tG<mc�k���2!^٫�����(��o@
'+s�1~R1�#��P��b���f�ֹ��      �   @   x�͹ !��x]̾1c�^�P�#�R~��a�=Y�(Q��:2��D-4�F�Rh!�q���G��      �   u   x�̹1���*�#�_{����0�!���O흕=�!b\�E�&n���h�5f���^e��గ�܄�<�1^B9ȥ�Rr)�����An� �r�[9ȭ�V>ȭ|�[� ��������o(	     