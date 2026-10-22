--
-- PostgreSQL database dump
--

\restrict X15JkeybsQIPsqQQ5OGiQFp32txNubEd6HWdXCJsvr2o3nu0BUoAef2v7Zu8NAz

-- Dumped from database version 18.6 (Postgres.app)
-- Dumped by pg_dump version 18.6 (Postgres.app)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: collisions; Type: TABLE; Schema: public; Owner: davidfaria
--

CREATE TABLE public.collisions (
    collision_index bigint NOT NULL,
    longitude double precision,
    latitude double precision,
    number_of_casualties integer,
    date character varying,
    "time" character varying,
    local_authority_ons_district character varying,
    speed_limit integer,
    dia_semana character varying,
    hora integer,
    periodo_dia character varying,
    numero_veiculos integer,
    descricao_gravidade character varying,
    descricao_tipo_area character varying,
    descricao_superficie_estrada character varying,
    descricao_luminosidade character varying,
    data_hora_acidente character varying,
    temperatura double precision,
    "Precipitação" double precision,
    "Velocidade_vento" double precision,
    condicao_meteorologica character varying
);


ALTER TABLE public.collisions OWNER TO davidfaria;

--
-- Name: vehicles; Type: TABLE; Schema: public; Owner: davidfaria
--

CREATE TABLE public.vehicles (
    collision_index bigint NOT NULL,
    vehicle_reference integer NOT NULL,
    vehicle_type integer,
    vehicle_manoeuvre integer,
    skidding_and_overturning integer,
    sex_of_driver integer,
    age_of_driver integer,
    faixa_etaria character varying,
    sexo_condutor character varying,
    categoria_veiculo character varying
);


ALTER TABLE public.vehicles OWNER TO davidfaria;

--
-- Name: collisions pk_collisions; Type: CONSTRAINT; Schema: public; Owner: davidfaria
--

ALTER TABLE ONLY public.collisions
    ADD CONSTRAINT pk_collisions PRIMARY KEY (collision_index);


--
-- Name: vehicles pk_vehicles; Type: CONSTRAINT; Schema: public; Owner: davidfaria
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT pk_vehicles PRIMARY KEY (collision_index, vehicle_reference);


--
-- Name: vehicles fk_vehicles_collisions; Type: FK CONSTRAINT; Schema: public; Owner: davidfaria
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT fk_vehicles_collisions FOREIGN KEY (collision_index) REFERENCES public.collisions(collision_index);


--
-- PostgreSQL database dump complete
--

\unrestrict X15JkeybsQIPsqQQ5OGiQFp32txNubEd6HWdXCJsvr2o3nu0BUoAef2v7Zu8NAz

