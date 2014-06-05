--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bairros; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bairros (
    id integer NOT NULL,
    nome character varying(255),
    cidade_id integer,
    estado_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: bairros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bairros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bairros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bairros_id_seq OWNED BY bairros.id;


--
-- Name: cargos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cargos (
    id integer NOT NULL,
    nome character varying(255),
    entidade_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: cargos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cargos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cargos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cargos_id_seq OWNED BY cargos.id;


--
-- Name: cidades; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cidades (
    id integer NOT NULL,
    nome character varying(255),
    estado_id integer,
    capital boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: cidades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cidades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cidades_id_seq OWNED BY cidades.id;


--
-- Name: combustiveis; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE combustiveis (
    id integer NOT NULL,
    nome character varying(255),
    valor_centavos integer,
    valor_currency character varying(255) DEFAULT 'BRL'::character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: combustiveis_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE combustiveis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: combustiveis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE combustiveis_id_seq OWNED BY combustiveis.id;


--
-- Name: configuracoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE configuracoes (
    id integer NOT NULL,
    skin character varying(255),
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: configuracoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE configuracoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: configuracoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE configuracoes_id_seq OWNED BY configuracoes.id;


--
-- Name: departamentos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE departamentos (
    id integer NOT NULL,
    nome character varying(255),
    descricao character varying(255),
    entidade_id integer,
    responsavel_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: departamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE departamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: departamentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE departamentos_id_seq OWNED BY departamentos.id;


--
-- Name: empresas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE empresas (
    id integer NOT NULL,
    nome character varying(255),
    cnpj character varying(255),
    endereco_id integer,
    responsavel_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: empresas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE empresas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: empresas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE empresas_id_seq OWNED BY empresas.id;


--
-- Name: enderecos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE enderecos (
    id integer NOT NULL,
    logradouro character varying(255),
    numero character varying(255),
    complemento character varying(255),
    cep character varying(255),
    bairro_id integer,
    cidade_id integer,
    estado_id integer,
    latitude double precision,
    longitude double precision,
    enderecavel_id integer,
    enderecavel_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: enderecos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE enderecos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enderecos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE enderecos_id_seq OWNED BY enderecos.id;


--
-- Name: estados; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE estados (
    id integer NOT NULL,
    sigla character varying(255),
    nome character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: estados_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE estados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: estados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE estados_id_seq OWNED BY estados.id;


--
-- Name: modalidades; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE modalidades (
    id integer NOT NULL,
    nome character varying(255),
    periodo_diario integer DEFAULT 8,
    dias_mes integer DEFAULT 22,
    com_motorista boolean DEFAULT false,
    com_combustivel boolean DEFAULT false,
    quilometragem_livre boolean DEFAULT false,
    mes_completo boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: modalidades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE modalidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: modalidades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE modalidades_id_seq OWNED BY modalidades.id;


--
-- Name: patios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE patios (
    id integer NOT NULL,
    data_entrada timestamp without time zone,
    veiculo_id integer,
    motorista_id integer,
    empresa_id integer,
    data_saida timestamp without time zone,
    state character varying(255),
    "position" integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: patios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE patios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE patios_id_seq OWNED BY patios.id;


--
-- Name: pessoas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pessoas (
    id integer NOT NULL,
    nome character varying(255),
    cpf character varying(255),
    email character varying(255),
    matricula character varying(255),
    cargo_id integer,
    entidade_id integer,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: pessoas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pessoas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pessoas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pessoas_id_seq OWNED BY pessoas.id;


--
-- Name: requisicoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE requisicoes (
    id integer NOT NULL,
    numero character varying(255),
    tipo_deslocamento character varying(255),
    descricao character varying(255),
    requisitante_id integer,
    data date,
    hora time without time zone,
    periodo character varying(255),
    periodo_longo boolean,
    inicio timestamp without time zone,
    fim timestamp without time zone,
    posto_id integer,
    preferencia_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: requisicoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE requisicoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: requisicoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE requisicoes_id_seq OWNED BY requisicoes.id;


--
-- Name: requisicoes_rotas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE requisicoes_rotas (
    id integer NOT NULL,
    rota_id integer,
    requisicao_id integer
);


--
-- Name: requisicoes_rotas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE requisicoes_rotas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: requisicoes_rotas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE requisicoes_rotas_id_seq OWNED BY requisicoes_rotas.id;


--
-- Name: rotas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rotas (
    id integer NOT NULL,
    destino character varying(255),
    roteavel_type character varying(255),
    roteavel_id integer,
    tempo_previsto character varying(255),
    latitude double precision,
    longitude double precision,
    rota_longa boolean,
    intermunicipal boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: rotas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rotas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rotas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rotas_id_seq OWNED BY rotas.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    nome character varying(255),
    cpf character varying(255),
    authentication_token character varying(255),
    role integer
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: veiculos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE veiculos (
    id integer NOT NULL,
    tipo integer,
    placa character varying(255),
    motor character varying(255),
    direcao integer,
    marca integer,
    modelo character varying(255),
    capacidade_carga integer DEFAULT 0,
    capacidade_passageiros integer DEFAULT 4,
    ano_fabricacao integer,
    ano_modelo integer,
    intens_obrigatorios boolean DEFAULT false,
    observacao text,
    qrcode character varying(255),
    codigo_de_barras character varying(255),
    gps_ip character varying(255),
    gps_imei character varying(255),
    modalidade_id integer,
    combustivel_id integer,
    turno_id integer,
    empresa_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: veiculos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE veiculos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: veiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE veiculos_id_seq OWNED BY veiculos.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bairros ALTER COLUMN id SET DEFAULT nextval('bairros_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cargos ALTER COLUMN id SET DEFAULT nextval('cargos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cidades ALTER COLUMN id SET DEFAULT nextval('cidades_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY combustiveis ALTER COLUMN id SET DEFAULT nextval('combustiveis_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY configuracoes ALTER COLUMN id SET DEFAULT nextval('configuracoes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY departamentos ALTER COLUMN id SET DEFAULT nextval('departamentos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY empresas ALTER COLUMN id SET DEFAULT nextval('empresas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY enderecos ALTER COLUMN id SET DEFAULT nextval('enderecos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY estados ALTER COLUMN id SET DEFAULT nextval('estados_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY modalidades ALTER COLUMN id SET DEFAULT nextval('modalidades_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY patios ALTER COLUMN id SET DEFAULT nextval('patios_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pessoas ALTER COLUMN id SET DEFAULT nextval('pessoas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY requisicoes ALTER COLUMN id SET DEFAULT nextval('requisicoes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY requisicoes_rotas ALTER COLUMN id SET DEFAULT nextval('requisicoes_rotas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rotas ALTER COLUMN id SET DEFAULT nextval('rotas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY veiculos ALTER COLUMN id SET DEFAULT nextval('veiculos_id_seq'::regclass);


--
-- Name: bairros_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bairros
    ADD CONSTRAINT bairros_pkey PRIMARY KEY (id);


--
-- Name: cargos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cargos
    ADD CONSTRAINT cargos_pkey PRIMARY KEY (id);


--
-- Name: cidades_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cidades
    ADD CONSTRAINT cidades_pkey PRIMARY KEY (id);


--
-- Name: combustiveis_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY combustiveis
    ADD CONSTRAINT combustiveis_pkey PRIMARY KEY (id);


--
-- Name: configuracoes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY configuracoes
    ADD CONSTRAINT configuracoes_pkey PRIMARY KEY (id);


--
-- Name: departamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY departamentos
    ADD CONSTRAINT departamentos_pkey PRIMARY KEY (id);


--
-- Name: empresas_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY empresas
    ADD CONSTRAINT empresas_pkey PRIMARY KEY (id);


--
-- Name: enderecos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY enderecos
    ADD CONSTRAINT enderecos_pkey PRIMARY KEY (id);


--
-- Name: estados_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY estados
    ADD CONSTRAINT estados_pkey PRIMARY KEY (id);


--
-- Name: modalidades_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY modalidades
    ADD CONSTRAINT modalidades_pkey PRIMARY KEY (id);


--
-- Name: patios_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY patios
    ADD CONSTRAINT patios_pkey PRIMARY KEY (id);


--
-- Name: pessoas_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pessoas
    ADD CONSTRAINT pessoas_pkey PRIMARY KEY (id);


--
-- Name: requisicoes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY requisicoes
    ADD CONSTRAINT requisicoes_pkey PRIMARY KEY (id);


--
-- Name: requisicoes_rotas_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY requisicoes_rotas
    ADD CONSTRAINT requisicoes_rotas_pkey PRIMARY KEY (id);


--
-- Name: rotas_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rotas
    ADD CONSTRAINT rotas_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: veiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY veiculos
    ADD CONSTRAINT veiculos_pkey PRIMARY KEY (id);


--
-- Name: index_bairros_on_nome; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bairros_on_nome ON bairros USING btree (nome);


--
-- Name: index_cargos_on_entidade_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cargos_on_entidade_id ON cargos USING btree (entidade_id);


--
-- Name: index_cidades_on_nome; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cidades_on_nome ON cidades USING btree (nome);


--
-- Name: index_departamentos_on_entidade_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_departamentos_on_entidade_id ON departamentos USING btree (entidade_id);


--
-- Name: index_departamentos_on_responsavel_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_departamentos_on_responsavel_id ON departamentos USING btree (responsavel_id);


--
-- Name: index_enderecos_on_latitude; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_enderecos_on_latitude ON enderecos USING btree (latitude);


--
-- Name: index_enderecos_on_logradouro; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_enderecos_on_logradouro ON enderecos USING btree (logradouro);


--
-- Name: index_enderecos_on_longitude; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_enderecos_on_longitude ON enderecos USING btree (longitude);


--
-- Name: index_enderecos_on_numero; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_enderecos_on_numero ON enderecos USING btree (numero);


--
-- Name: index_estados_on_sigla; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_estados_on_sigla ON estados USING btree (sigla);


--
-- Name: index_patios_on_empresa_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_patios_on_empresa_id ON patios USING btree (empresa_id);


--
-- Name: index_patios_on_motorista_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_patios_on_motorista_id ON patios USING btree (motorista_id);


--
-- Name: index_patios_on_veiculo_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_patios_on_veiculo_id ON patios USING btree (veiculo_id);


--
-- Name: index_pessoas_on_cargo_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pessoas_on_cargo_id ON pessoas USING btree (cargo_id);


--
-- Name: index_pessoas_on_entidade_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pessoas_on_entidade_id ON pessoas USING btree (entidade_id);


--
-- Name: index_pessoas_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pessoas_on_user_id ON pessoas USING btree (user_id);


--
-- Name: index_requisicoes_on_posto_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_requisicoes_on_posto_id ON requisicoes USING btree (posto_id);


--
-- Name: index_requisicoes_on_preferencia_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_requisicoes_on_preferencia_id ON requisicoes USING btree (preferencia_id);


--
-- Name: index_requisicoes_on_requisitante_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_requisicoes_on_requisitante_id ON requisicoes USING btree (requisitante_id);


--
-- Name: index_requisicoes_rotas_on_requisicao_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_requisicoes_rotas_on_requisicao_id ON requisicoes_rotas USING btree (requisicao_id);


--
-- Name: index_requisicoes_rotas_on_rota_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_requisicoes_rotas_on_rota_id ON requisicoes_rotas USING btree (rota_id);


--
-- Name: index_rotas_on_roteavel_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rotas_on_roteavel_id ON rotas USING btree (roteavel_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_veiculos_on_combustivel_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_veiculos_on_combustivel_id ON veiculos USING btree (combustivel_id);


--
-- Name: index_veiculos_on_empresa_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_veiculos_on_empresa_id ON veiculos USING btree (empresa_id);


--
-- Name: index_veiculos_on_modalidade_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_veiculos_on_modalidade_id ON veiculos USING btree (modalidade_id);


--
-- Name: index_veiculos_on_turno_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_veiculos_on_turno_id ON veiculos USING btree (turno_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140520111441');

INSERT INTO schema_migrations (version) VALUES ('20140520111442');

INSERT INTO schema_migrations (version) VALUES ('20140520111446');

INSERT INTO schema_migrations (version) VALUES ('20140521131210');

INSERT INTO schema_migrations (version) VALUES ('20140521132327');

INSERT INTO schema_migrations (version) VALUES ('20140522181322');

INSERT INTO schema_migrations (version) VALUES ('20140522181404');

INSERT INTO schema_migrations (version) VALUES ('20140522181437');

INSERT INTO schema_migrations (version) VALUES ('20140523171554');

INSERT INTO schema_migrations (version) VALUES ('20140523172711');

INSERT INTO schema_migrations (version) VALUES ('20140526154633');

INSERT INTO schema_migrations (version) VALUES ('20140526175329');

INSERT INTO schema_migrations (version) VALUES ('20140528132729');

INSERT INTO schema_migrations (version) VALUES ('20140529195608');

INSERT INTO schema_migrations (version) VALUES ('20140530130517');

INSERT INTO schema_migrations (version) VALUES ('20140530131648');

INSERT INTO schema_migrations (version) VALUES ('20140530132656');

INSERT INTO schema_migrations (version) VALUES ('20140530195329');

INSERT INTO schema_migrations (version) VALUES ('20140530200606');

