clear all

#d;

infix	

V0101	1-4	/*Ano de referência*/
UF	5-6	/*Unidade da Federação*/
V0102	5-12	/*Número de controle*/
V0103	13-15	/*Número de série*/
V0301	16-17	/*Número de ordem*/
V0302	18	/*Sexo*/
V3031	19-20	/*Dia de nascimento*/
V3032	21-22	/*Mês de nascimento*/
V3033	23-26	/*Ano de nascimento*/
V8005	27-29	/*Idade do morador na data de referência*/
V0401	30	/*Condição na unidade domiciliar*/
V0402	31	/*Condição na família*/
V0403	32	/*Número da família*/
V0404	33	/*Cor ou raça*/
V0405	34	/*Tem mãe viva*/
V0406	35	/*Mãe mora no domicílio*/
V0407	36-37	/*Número de ordem da mãe */
V0408	38	/*Tem registro de nascimento*/
V4111	39	/*Vive em companhia de cônjuge ou companheiro(a)*/
V4112	40	/*Natureza da união*/
V4011	41	/*Estado civil*/
V0412	42	/*O informante desta parte foi*/
V0501	43	/*Nasceu no município de residência*/
V0502	44	/*Nasceu na Unidade da Federação de residência*/
V5030	45-46	/*Lugar de nascimento*/
V0504	47	/*Morou em outra Unidade da Federação ou país estrangeiro*/
V0505	48	/*Morava na Unidade da Federação na data de referência */
V5061	49	/*Tinha até 4 anos ininterruptos de residência na Unidade da Federação*/
V5062	50	/*Tempo de residência na Unidade da Federação (até 4 anos)*/
V5063	51	/*Tinha de 5 a 9 anos ininterruptos de residência na Unidade da Federação*/
V5064	52	/*Tempo de residência na Unidade da Federação (de 5 a 9 anos)*/
V5065	53	/*Tinha 10 anos ou mais de residência na Unidade da Federação*/
V0507	54	/*Morava na Unidade da Federação há 5 anos da data de referência*/
V5080	55-56	/*Lugar de residência há 5 anos da data de referência*/
V5090	57-58	/*Lugar de residência anterior*/
V0510	59	/*Morava no município na data de referência*/
V0511	60	/*Morou em outro município na Unidade da Federação*/
V5121	61	/*Tinha até 4 anos ininterruptos de residência no município*/
V5122	62	/*Tempo de residência no município (até 4 anos)*/
V5123	63	/*Tinha de 5 a 9 anos ininterruptos de residência no município*/
V5124	64	/*Tempo de residência no município (de 5 a 9 anos)*/
V5125	65	/*Tinha 10 anos ou mais de residência no município*/
V5126	66	/*O informante desta parte foi*/
V0601	67	/*Sabe ler e escrever*/
V0602	68	/*Frequenta escola ou creche*/
V6002	69	/*Rede de ensino*/
V6020	70	/*Área da rede pública de ensino*/
V6003	71-72	/*Curso que frequenta*/
V6030	73	/*Duração do ensino fundamental*/
V0604	74	/*O curso que frequenta é seriado*/
V0605	75	/*Série que frequenta*/
V0606	76	/*Anteriormente frequentou escola ou creche*/
V6007	77-78	/*Curso mais elevado que frequentou anteriormente*/
V6070	79	/*Duração do ensino fundamental que frequentou anteriormente*/
V0608	80	/*Este curso que frequentou anteriormente era seriado*/
V0609	81	/*Concluiu, com aprovação, pelo menos a 1ª série deste curso que frequentou anteriormente*/
V0610	82	/*Última série concluída com aprovação, neste curso que frequentou anteriormente*/
V0611	83	/*Concluiu este curso que frequentou anteriormente*/
V06111	84	/*Nos últimos três meses, utilizou a Internet em algum local*/
V061111	85	/*Nos últimos doze meses, utilizou a Internet em algum local*/
V061112	86	/*O acesso à Internet foi feito através de microcomputador*/
V061113	87	/*O acesso à Internet foi feito através de telefone celular*/
V061114	88	/*O acesso à Internet foi feito através de tablet*/
V061115	89	/*O acesso à Internet foi feito através de tv*/
V061116	90	/*O acesso à Internet foi feito através de outro equipamento eletrônico*/
V06112	91	/*Tem telefone móvel celular para uso pessoal*/
V0612	92	/*O informante desta parte foi*/
V0701	93	/*Teve algum trabalho no período de referência de 365 dias*/
V0702	94	/*Exerceu tarefas em cultivo, pesca ou criação de animais, destinados à própria alimentação das pessoas moradoras no domicílio, no período de referência de 365 dias*/
V0703	95	/*Exerceu tarefas em construção de prédio, cômodo, poço ou outras obras de construção, destinadas ao próprio uso das pessoas moradoras no domicílio, no período de referência de 365 dias*/
V0704	96	/*Trabalhou na semana de referência*/
V0705	97	/*Esteve afastado temporariamente do trabalho remunerado que tinha na semana de referência*/
V7060	98-101	/*Código da ocupação no trabalho do período de captação de 358 dias*/
V7070	102-106	/*Código da atividade principal do empreendimento no trabalho do período de captação de 358 dias*/
V0708	107	/*Posição na ocupação no trabalho do período de captação de 358 dias*/
V7090	108-111	/*Código da ocupação no trabalho da semana de referência*/
V7100	112-116	/*Código da atividade principal do empreendimento no trabalho da semana de referência*/
V0711	117	/*Posição na ocupação no trabalho da semana de referência*/
V7121	118	/*Código 2 - recebia normalmente rendimento mensal em dinheiro no mês de referência no(s) trabalho(s) da semana de referência*/
V7122	119-130	/*Rendimento mensal em dinheiro que recebia normalmente no mês de referência no(s) trabalho(s) da semana de referência*/
V7124	131	/*Código 4 - recebia normalmente rendimento mensal em produtos ou mercadorias no mês de referência no(s) trabalho(s) da semana de referência*/
V7125	132-143	/*Rendimento mensal em valor dos produtos ou mercadorias que recebia normalmente no mês de referência no(s) trabalho(s) da semana de referência*/
V7127	144	/*Código 6 - recebia normalmente rendimento mensal somente em benefícios no mês de referência no(s) trabalho(s) da semana de referência*/
V7128	145	/*Código 8 - era trabalhador não remunerado no(s) trabalho(s) da semana de referência*/
V0713	146-147	/*Número de horas habitualmente trabalhadas por semana no(s) trabalho(s) da semana de referência*/
V0714	148	/*Cuidava dos afazeres domésticos na semana de referência*/
V0715	149-150	/*Número de horas que dedicava normalmente por semana aos afazeres domésticos*/
V0716	151	/*O informante desta parte foi*/
V9001	152	/*Trabalhou na semana de referência*/
V9002	153	/*Esteve afastado temporariamente do trabalho remunerado que tinha na semana de referência*/
V9003	154	/*Exerceu tarefas em cultivo, pesca ou criação de animais, destinados à própria alimentação das pessoas moradoras no domicílio, na semana de referência*/
V9004	155	/*Exerceu tarefas em construção de prédio, cômodo, poço ou outras obras de construção, destinadas ao próprio uso das pessoas moradoras no domicílio, na semana de referência*/
V9005	156	/*Número de trabalhos que tinha na semana de referência*/
V9906	157-160	/*Código da ocupação no trabalho principal da semana de referência*/
V9907	161-165	/*Código da atividade principal do empreendimento no trabalho principal da semana de referência*/
V9008	166-167	/*Posição na ocupação no trabalho principal da semana de referência*/
V9009	168	/*Recebia do empregador alguma área para produção particular*/
V9010	169	/*Tinha parceria com o empregador*/
V90101	170	/*Foi contratado somente por pessoa responsável pelo estabelecimento*/
V9011	171	/*Foi contratado somente por pessoa(s) responsável(véis) pelo(s) estabelecimento(s) em que trabalhou como empregado temporário no mês de referência*/
V9012	172	/*Foi contratado como empregado temporário, somente por intermediário (empresa empreiteira, empreiteiro, gato, etc.) no mês de referência*/
V90121	173	/*Foi contratado por intemédio de*/
V9013	174	/*Teve ajuda de trabalhador não remunerado membro da unidade domiciliar no mês de referência*/
V9014	175	/*Número de trabalhadores não remunerados membros da unidade domiciliar, independentemente da idade, que ajudaram à pessoa que era empregado no mês de referência*/
V9151	176	/*Código 1 - referente à 1ª parcela ou parcela única do empreendimento*/
V9152	177-187	/*Área informada na 1ª parcela ou parcela única do empreendimento*/
V9154	188-194	/*Equivalência em m², referente à unidade de medida de superfície em V9152*/
V9156	195	/*Código 3 - referente à 2ª parcela do empreendimento*/
V9157	196-206	/*Área informada na 2ª parcela do empreendimento*/
V9159	207-213	/*Equivalência em m², referente à unidade de medida de superfície em V9157*/
V9161	214	/*Código 5 - referente à 3ª parcela do empreendimento*/
V9162	215-225	/*Área informada na 3ª parcela do empreendimento*/
V9164	226-232	/*Equivalência em m², referente à unidade de medida de superfície em V9162*/
V9016	233	/*Tinha pelo menos um empregado temporário, no mês de referência, no trabalho principal da semana de referência*/
V9017	234	/*Número de empregados temporários, no mês de referência, no trabalho principal da semana de referência*/
V9018	235	/*Tinha pelo menos um empregado permanente, no mês de referência, no trabalho principal da semana de referência*/
V9019	236	/*Número de empregados permanentes, no mês de referência, no trabalho principal da semana de referência*/
V9201	237	/*Código 2 - referente à 1ª parcela ou parcela única do empreendimento*/
V9202	238-248	/*Área informada na 1ª parcela ou parcela única do empreendimento*/
V9204	249-255	/*Equivalência em m², referente à unidade de medida de superfície em V9202*/
V9206	256	/*Código 4 - referente à 2ª parcela do empreendimento*/
V9207	257-267	/*Área informada na 2ª parcela do empreendimento*/
V9209	268-274	/*Equivalência em m², referente à unidade de medida de superfície em V9207*/
V9211	275	/*Código 6 - referente à 3ª parcela do empreendimento*/
V9212	276-286	/*Área informada na 3ª parcela do empreendimento*/
V9214	287-293	/*Equivalência em m², referente à unidade de medida de superfície em V9212*/
V9021	294	/*Condição em relação ao empreendimento do grupamento agrícola*/
V9022	295	/*Parceria contratada neste trabalho*/
V9023	296	/*Forma contratada de pagamento pelo uso do bem, móvel ou imóvel, arrendado para o empreendimento*/
V9024	297	/*Assumiu, previamente, o compromisso de vender uma parte da produção principal do empreendimento no período de referência de 365 dias*/
V9025	298	/*Vendeu alguma parte da produção principal do empreendimento no período de referência de 365 dias*/
V9026	299	/*Comprador que adquiriu a totalidade, ou a maior parte, da produção principal do empreendimento que foi vendida no período de referência de 365 dias.*/
V9027	300	/*Algum tipo de produção desenvolvida no empreendimento foi consumida como alimentação pelos membros da unidade domiciliar no mês de referência*/
V9028	301	/*Parcela da alimentação consumida pelos membros da unidade domiciliar, no mês de referência, que foi retirada de produção desenvolvida no empreendimento*/
V9029	302	/*Posição na ocupação no trabalho principal da semana de referência*/
V9030	303	/*A jornada normal desse trabalho estava totalmente compreendida no período de 5 horas da manhã às 10 horas da noite*/
V9031	304	/*A jornada normal desse trabalho estava totalmente compreendida no período noturno de 10 horas da noite às 5 horas da manhã seguinte*/
V9032	305	/*Setor do emprego no trabalho principal da semana de referência*/
V9033	306	/*Área do emprego no trabalho principal da semana de referência*/
V9034	307	/*Era militar do Exército, Marinha de Guerra ou Aeronáutica no trabalho principal da semana de referência*/
V9035	308	/*Era funcionário público estatutário no trabalho principal da semana de referência*/
V9036	309	/*Prestava serviço doméstico remunerado em mais de um domicílio, no mês de referência*/
V9037	310	/*Exercia habitualmente esse trabalho pelo menos uma vez por semana*/
V9038	311	/*Número de dias por semana que, habitualmente, prestava serviço doméstico remunerado*/
V9039	312	/*Número de dias por mês que, habitualmente, prestava serviço doméstico remunerado*/
V9040	313	/*Número de pessoas ocupadas, no mês de referência, no empreendimento do trabalho principal da semana de referência*/
V9041	314	/*Forma contratada, verbalmente ou por escrito, para o cálculo da remuneração no trabalho principal da semana de referência*/
V9042	315	/*Tinha carteira de trabalho assinada no trabalho principal da semana de referência */
V9043	316	/*Recebeu auxílio para moradia no mês de referência*/
V9044	317	/*Recebeu auxílio para alimentação no mês de referência*/
V9045	318	/*Recebeu auxílio para transporte no mês de referência*/
V9046	319	/*Recebeu auxílio para educação ou creche no mês de referência*/
V9047	320	/*Recebeu auxílio para saúde ou reabilitação no mês de referência*/
V9048	321	/*Número de empregados, no mês de referência, no empreendimento do trabalho principal da semana de referência*/
V9049	322	/*Tinha pelo menos um sócio ocupado, no mês de referência, no empreendimento do trabalho principal da semana de referência*/
V9050	323	/*Número de sócios ocupados, no mês de referência, no empreendimento do trabalho principal da semana de referência*/
V9051	324	/*Tinha pelo menos um trabalhador não remunerado, no mês de referência, no trabalho principal da semana de referência*/
V9052	325	/*Número de trabalhadores não remunerados ocupados, no mês de referência, no trabalho principal da semana de referência*/
V9531	326	/*Código 1 - recebia normalmente rendimento mensal em dinheiro, no mês de referência, no trabalho principal da semana de referência*/
V9532	327-338	/*Rendimento mensal em dinheiro que recebia normalmente, no mês de referência, no trabalho principal da semana de referência*/
V9534	339	/*Código 3 - recebia normalmente rendimento mensal em produtos ou mercadorias, no mês de referência, no trabalho principal da semana de referência*/
V9535	340-351	/*Rendimento mensal em valor dos produtos ou mercadorias que recebia normalmente, no mês de referência, no trabalho principal da semana de referência*/
V9537	352	/*Código 5 - recebia normalmente rendimento mensal somente em benefícios, no mês de referência, no trabalho principal da semana de referência*/
V90531	353	/*O empreendimento tem registro no Cadastro Nacional de Pessoa Jurídica - CNPJ*/
V90532	354	/*Esse empreendimento possuía fatura ou nota fiscal para emitir aos clientes*/
V90533	355	/*Esse empreendimento entregava contracheque a seus funcionários*/
V9054	356	/*Tipo de estabelecimento ou onde era exercido o trabalho principal da semana de referência*/
V9055	357	/*Morava em domicílio que estava no mesmo terreno ou área do estabelecimento em que tinha trabalho*/
V9056	358	/*Ia direto do domicílio em que morava para o trabalho*/
V9057	359	/*Tempo de percurso diário de ida da residência para o local de trabalho*/
V9058	360-361	/*Número de horas habitualmente trabalhadas por semana no trabalho principal da semana de referência*/
V9059	362	/*Era contribuinte para instituto de previdência no trabalho principal da semana de referência*/
V9060	363	/*Instituto de previdência para o qual contribuía no trabalho principal da semana de referência*/
V9611	364-365	/*Número de anos no trabalho principal da semana de referência, contados até a data de referência*/
V9612	366-367	/*Número de meses no trabalho principal da semana de referência, contados até a data de referência*/
V9062	368	/*Saiu de algum trabalho no período de captação de 358 dias*/
V9063	369	/*De quantos trabalhos saiu no período de captação de 358 dias*/
V9064	370-371	/*Número de meses que permaneceu nesse trabalho anterior no período de captação de 358 dias*/
V9065	372	/*Era empregado com carteira de trabalho assinada nesse trabalho anterior*/
V9066	373	/*Recebeu seguro-desemprego depois que saiu desse emprego anterior*/
V9067	374	/*Teve algum trabalho no período de captação de 358 dias*/
V9068	375	/*Exerceu tarefas em cultivo, pesca ou criação de animais, destinados à própria alimentação das pessoas moradoras no domicílio, no período de captação de 358 dias*/
V9069	376	/*Exerceu tarefas em construção de prédio, cômodo, poço ou outras obras de construção, destinadas ao próprio uso das pessoas moradoras no domicílio, no período de captação de 358 dias*/
V9070	377	/*De quantos trabalhos saiu no período de captação de 358 dias*/
V9971	378-381	/*Código da ocupação no trabalho anterior do período de captação de 358 dias */
V9972	382-386	/*Código da atividade principal do empreendimento no trabalho anterior do período de captação de 358 dias*/
V9073	387-388	/*Posição na ocupação no trabalho anterior do período de captação de 358 dias*/
V9074	389	/*Nesse emprego anterior recebia do empregador alguma área para produção particular*/
V9075	390	/*Nesse emprego anterior tinha parceria com o empregador*/
V9076	391	/*Condição em relação ao empreendimento agrícola nesse trabalho anterior*/
V9077	392	/*Posição na ocupação nesse trabalho anterior*/
V9078	393	/*Setor do emprego nesse trabalho anterior*/
V9079	394	/*Área do emprego nesse trabalho anterior*/
V9080	395	/*Era militar do Exército, Marinha de Guerra ou Aeronáutica nesse trabalho anterior*/
V9081	396	/*Era funcionário público estatutário nesse trabalho anterior*/
V9082	397	/*Prestava serviço doméstico remunerado em mais de um domicílio nos últimos 30 dias em que esteve nesse trabalho anterior*/
V9083	398	/*Tinha carteira de trabalho assinada nesse trabalho anterior*/
V9084	399	/*Após sair desse emprego anterior, recebeu seguro-desemprego*/
V9085	400	/*Era contribuinte de instituto de previdência por esse trabalho anterior*/
V9861	401-402	/*Número de anos nesse trabalho anterior*/
V9862	403-404	/*Número de meses nesse trabalho anterior*/
V9087	405	/*Era associado a algum sindicato no mês de referência*/
V90871	406	/*Embora não fosse associado, costumava participar de alguma atividade promovida por sindicato ligado a algum trabalho que teve no período de referência de 365 dias*/
V908721	407	/*Costumava participar de assembleias */
V908722	408	/*Costumava participar de manifestações */
V908723	409	/*Costumava participar de palestras, cursos ou debates */
V908724	410	/*Costumava participar de eventos comemorativos*/
V908725	411	/*Costumava participar de atividades de lazer ou esportivas */
V908726	412	/*Costumava participar de outra atividade*/
V90873	413	/*Já foi associado a algum sindicato anteriormente*/
V90874	414	/*Motivo pelo qual não era associado a algum sindicato no mês de referência*/
V9088	415	/*Tipo de sindicato*/
V90881	416	/* Motivo pelo qual se associou a esse sindicato*/
V90882	417	/* Costuma utilizar algum serviço oferecido por esse sindicato*/
V908831	418	/* Costuma utilizar atendimento jurídico*/
V908832	419	/* Costuma utilizar convênio médico ou odontológico*/
V908833	420	/* Costuma utilizar atendimento médico ou odontológico*/
V908834	421	/* Costuma utilizar convênio com instituição de ensino, curso ou creche*/
V908835	422	/* Costuma utilizar convênio com estabelecimento comercial ou de serviço (ótica, farmácia, restaurante, academia de ginástica etc)*/
V908836	423	/* Costuma utilizar seguro de vida*/
V908837	424	/* Costuma utilizar outro serviço*/
V90884	425	/* Costumava participar de alguma atividade promovida por esse sindicato*/
V908851	426	/* Costumava participar de assembleias*/
V908852	427	/* Costumava participar de manifestações*/
V908853	428	/* Costumava participar de palestras, cursos ou debates*/
V908854	429	/* Costumava participar de eventos comemorativos*/
V908855	430	/* Costumava participar de atividades de lazer ou esportivas*/
V908856	431	/* Costumava participar de outra atividade*/
V90886	432	/* No mês de referência, tinha algum cargo de representação dos trabalhadores na organização desse sindicato*/
V90887	433	/* No período de 365 dias, houve participação desse sindicato em negociação ou dissídio coletivo no trabalho principal que tinha na semana de referência*/
V908881	434	/* Aspectos tratados em negociações referem-se a rendimentos monetários*/
V908882	435	/* Aspectos tratados em negociações referem-se a benefícios*/
V908883	436	/* Aspectos tratados em negociações referem-se a jornada de trabalho*/
V908884	437	/* Aspectos tratados em negociações referem-se a condições de saúde e segurança no trabalho*/
V908885	438	/* Aspectos tratados em negociações referem-se a treinamento ou capacitação para o trabalho*/
V908886	439	/* Aspectos tratados em negociações referem-se a igualdade de oportunidades e de tratamento*/
V908887	440	/* Aspectos tratados em negociações referem-se a outro */
V9891	441	/*Faixa de idade em que começou a trabalhar*/
V9892	442-443	/*Idade com que começou a trabalhar*/
V9990	444-447	/*Código da ocupação no trabalho secundário da semana de referência*/
V9991	448-452	/*Código da atividade principal do empreendimento no trabalho secundário da semana de referência*/
V9092	453	/*Posição na ocupação no trabalho secundário da semana de referência*/
V9093	454	/*Setor do emprego nesse trabalho secundário*/
V9094	455	/*Área do emprego nesse trabalho secundário*/
V9095	456	/*Era militar do Exército, Marinha de Guerra ou Aeronáutica nesse trabalho secundário*/
V9096	457	/*Era funcionário público estatutário nesse trabalho secundário*/
V9097	458	/*Tinha carteira de trabalho assinada nesse trabalho secundário */
V9981	459	/*Código 2 - recebia normalmente rendimento mensal em dinheiro, no mês de referência, nesse trabalho secundário*/
V9982	460-471	/*Rendimento mensal em dinheiro que recebia normalmente, no mês de referência, nesse trabalho secundário*/
V9984	472	/*Código 4 - recebia normalmente rendimento mensal em produtos ou mercadorias, no mês de referência, nesse trabalho secundário*/
V9985	473-484	/*Rendimento mensal em valor dos produtos ou mercadorias que recebia normalmente, no mês de referência, nesse trabalho secundário*/
V9987	485	/*Código 6 - recebia normalmente rendimento mensal somente em benefícios, no mês de referência, nesse trabalho secundário*/
V9099	486	/*Era contribuinte de instituto de previdência nesse trabalho secundário*/
V9100	487	/*Instituto de previdência para o qual contribuía nesse emprego secundário*/
V9101	488-489	/*Número de horas habitualmente trabalhadas por semana nesse trabalho secundário*/
V1021	490	/*Código 2 - recebia normalmente rendimento mensal em dinheiro, no mês de referência, no(s) outro(s) trabalho(s) da semana de referência*/
V1022	491-502	/*Rendimento mensal em dinheiro que recebia normalmente, no mês de referência, no(s) outro(s) trabalho(s) da semana de referência*/
V1024	503	/*Código 4 - recebia normalmente rendimento mensal em produtos ou mercadorias, no mês de referência, no(s) outro(s) trabalho(s) da semana de referência*/
V1025	504-515	/*Rendimento mensal em valor dos produtos ou mercadorias que recebia normalmente, no mês de referência, no(s) outro(s) trabalho(s) da semana de referência*/
V1027	516	/*Código 6 - recebia normalmente rendimento mensal somente em benefícios no mês de referência, no(s) outro(s) trabalho(s) da semana de referência*/
V1028	517	/*Código 8 - era trabalhador não remunerado, no mês de referência, no(s) outro(s) trabalho(s) da semana de referência*/
V9103	518	/*Era contribuinte de instituto de previdência, por esse(s) outro(s) trabalho(s) da semana de referência*/
V9104	519	/*Instituto de previdência para o qual contribuía nesse(s) outro(s) trabalho(s) da semana de referência*/
V9105	520-521	/*Número de horas habitualmente trabalhadas por semana nesse(s) outro(s) trabalho(s) da semana de referência*/
V9106	522	/*Teve algum trabalho antes do período de referência de 365 dias*/
V9107	523	/*Exerceu tarefas em cultivo, pesca ou criação de animais, destinados à própria alimentação das pessoas moradoras no domicílio, antes do período de referência de 365 dias*/
V9108	524	/*Exerceu tarefas em construção de prédio, cômodo, poço ou outras obras de construção, destinadas ao próprio uso das pessoas moradoras no domicílio,  antes do período de referência de 365 dias*/
V1091	525-526	/*Número de anos, contados até a data de referência, desde que saiu do último trabalho*/
V1092	527-528	/*Número de meses, contados até a data de referência, desde que saiu do último trabalho*/
V9910	529-532	/*Código da ocupação no útimo trabalho que teve no período de referência de menos de 4 anos*/
V9911	533-537	/*Código da atividade principal do empreendimento nesse último trabalho que teve no período de referência de menos de 4 anos*/
V9112	538	/*Posição na ocupação no último trabalho no período de referência de menos de 4 anos*/
V9113	539	/*Era militar ou funcionário público estatutário nesse último trabalho */
V9114	540	/*Tinha carteira de trabalho assinada nesse último trabalho */
V9115	541	/*Tomou alguma providência para conseguir trabalho na semana de referência*/
V9116	542	/*Tomou alguma providência para conseguir trabalho no período de captação de 23 dias*/
V9117	543	/*Tomou alguma providência para conseguir trabalho no período de captação de 30 dias*/
V9118	544	/*Tomou alguma providência para conseguir trabalho no período de captação de 305 dias*/
V9119	545	/*Última providência que tomou para conseguir trabalho no período de referência de 365 dias*/
V9120	546	/*Era contribuinte de alguma entidade de previdência privada, no mês de referência*/
V9121	547	/*Cuidava dos afazeres domésticos na semana de referência*/
V9921	548-549	/*Número de horas que dedicava normalmente por semana aos afazeres domésticos*/
V9122	550	/*Era aposentado de instituto de previdência federal (INSS), estadual ou municipal ou do governo federal na semana de referência*/
V9123	551	/*Era pensionista de instituto de previdência federal (INSS), estadual ou municipal ou do governo federal na semana de referência*/
V9124	552	/*Recebia normalmente rendimento que não era proveniente de trabalho (pensão alimentícia ou de fundo de pensão, abono de permanência, aluguel, doação, juros de caderneta de poupança, dividendos ou outro qualquer */
V1251	553-554	/*Código 01 - recebia normalmente rendimento de aposentadoria de instituto de previdência ou do governo federal, no mês de referência*/
V1252	555-566	/*Rendimento de aposentadoria de instituto de previdência ou do governo federal que recebia, normalmente, no mês de referência*/
V1254	567-568	/*Código 02 - recebia normalmente rendimento de pensão de instituto de previdência ou do governo federal, no mês de referência*/
V1255	569-580	/*Rendimento de pensão de instituto de previdência ou do governo federal que recebia, normalmente, no mês de referência*/
V1257	581-582	/*Código 03 - recebia normalmente rendimento de outro tipo de aposentadoria, no mês de referência*/
V1258	583-594	/*Rendimento de outro tipo de aposentadoria que recebia, normalmente, no mês de referência*/
V1260	595-596	/*Código 04 - recebia normalmente rendimento de outro tipo de pensão, no mês de referência*/
V1261	597-608	/*Rendimento de outro tipo de pensão que recebia, normalmente, no mês de referência*/
V1263	609-610	/*Código 05 - recebia normalmente rendimento de abono de permanência, no mês de referência*/
V1264	611-622	/*Rendimento de abono de permanência que recebia, normalmente, no mês de referência*/
V1266	623-624	/*Código 06 - recebia normalmente rendimento de aluguel, no mês de referência*/
V1267	625-636	/*Rendimento de aluguel que recebia, normalmente, no mês de referência*/
V1269	637-638	/*Código 07 - recebia normalmente rendimento de doação de não morador, no mês de referência*/
V1270	639-650	/*Rendimento de doação de não morador que recebia, normalmente, no mês de referência*/
V1272	651-652	/*Código 08 - recebia normalmente juros de caderneta de poupança ou de outras aplicações financeiras, dividendos, programas sociais ou outros rendimentos, no mês de referência*/
V1273	653-664	/*Juros de caderneta de poupança e de outras aplicações financeiras, dividendos, programas sociais e outros rendimentos que recebia, normalmente, no mês de referência*/
V9126	665	/*O informante desta parte foi*/
V1101	666	/*Teve algum filho nascido vivo até a data de referência*/
V1141	667-668	/*Número de filhos tidos, do sexo masculino, que moravam no domicílio*/
V1142	669-670	/*Número de filhos tidos, do sexo feminino, que moravam no domicílio*/
V1151	671-672	/*Número de filhos tidos, do sexo masculino, ainda vivos que moravam em outro local qualquer*/
V1152	673-674	/*Número de filhos tidos, do sexo feminino, ainda vivos que moravam em outro local qualquer*/
V1153	675	/*Código 5 - Não sabe o número de filhos tidos, do sexo masculino, que moravam em outro local qualquer*/
V1154	676	/*Código 7 - Não sabe o número de filhos tidos, do sexo feminino, que moravam em outro local qualquer*/
V1161	677-678	/*Número de filhos tidos, do sexo masculino, que morreram*/
V1162	679-680	/*Número de filhos tidos, do sexo feminino, que morreram*/
V1163	681	/*Código 6 - Não sabe o número de filhos tidos, do sexo masculino, que já morreram*/
V1164	682	/*Código 8 - Não sabe o número de filhos tidos, do sexo feminino, que já morreram*/
V1107	683	/*Sexo do último filho tido nascido vivo até a data de referência*/
V1181	684-685	/*Mês de nascimento do último filho tido nascido vivo*/
V1182	686-689	/*Ano de nascimento do último filho tido nascido vivo*/
V1109	690	/*O último filho tido nascido vivo ainda estava vivo na data de referência*/
V1110	691	/*Teve algum filho, com 7 meses ou mais de gestação, que nasceu morto até a data de referência*/
V1111	692-693	/*Número de filhos tidos nascidos mortos, do sexo masculino, até a data de referência*/
V1112	694-695	/*Número de filhos tidos nascidos mortos, do sexo feminino, até a data de referência*/
V1113	696	/*Código 5 - Não sabe o número de filhos tidos nascidos mortos, do sexo masculino, até a data de referência*/
V1114	697	/*Código 7 - Não sabe o número de filhos tidos nascidos mortos, do sexo feminino, até a data de referência*/
V1115	698	/*O informante desta parte foi*/
V4801	699-700	/*Nível de ensino, duração do ensino fundamental e série que frequentavam (todos os estudantes)*/
V4802	701-702	/*Nível de ensino e grupos de séries do ensino fundamental que frequentavam (todos os estudantes)*/
V4803	703-704	/*Anos de estudo (todas as pessoas)*/
V4704	705	/*Condição de atividade*/
V4805	706	/*Condição de ocupação no período de referência de 365 dias*/
V4706	707-708	/*Posição na ocupação no trabalho principal*/
V4707	709	/*Horas habitualmente trabalhadas por semana em todos os trabalhos*/
V4808	710	/*Atividade principal do empreendimento do trabalho principal */
V4809	711-712	/*Grupamentos de atividade principal do empreendimento do trabalho principal */
V4810	713-714	/*Grupamentos ocupacionais do trabalho principal*/
V4711	715	/*Contribuição para instituto de previdência em qualquer trabalho */
V4812	716	/*Atividade principal do empreendimento no trabalho principal do período de referência de 365 dias*/
V4713	717	/*Condição de atividade no trabalho principal do período de referência de 365 dias*/
V4814	718	/*Condição de ocupação no período de referência de 365 dias*/
V4715	719-720	/*Posição na ocupação no trabalho principal do período de referência de 365 dias*/
V4816	721-722	/*Grupamentos de atividade no trabalho principal do período de referência de 365 dias*/
V4817	723-724	/*Grupamentos ocupacionais do trabalho principal do período de referência de 365 dias*/
V4718	725-736	/*Rendimento mensal do trabalho principal para pessoas de 10 anos ou mais de idade*/
V4719	737-748	/*Rendimento mensal de todos os trabalhos para pessoas de 10 anos ou mais de idade*/
V4720	749-760	/*Rendimento mensal de todas as fontes para pessoas de 10 anos ou mais de idade*/
V4721	761-772	/*Rendimento mensal domiciliar*/
V4722	773-784	/*Rendimento mensal familiar */
V4723	785-786	/*Tipo de família*/
V4724	787-788	/*Número de componentes da família */
V4727	789	/*Código de área censitária*/
V4728	790	/*Código de situação censitária*/
V4729	791-795	/*Peso da pessoa*/
V4732	796-800	/*Peso da família*/
V4735	801	/*Controle da tabulação de fecundidade, para mulheres com 10 anos ou mais de idade*/
V4838	802	/*Grupos de anos de estudo*/
V6502	803	/*Criança de 5 a 17 anos de idade*/
V4741	804-805	/*Número de componentes do domícilio */
V4742	806-817	/*Rendimento mensal domiciliar per capita */
V4743	818-819	/*Faixa de rendimento mensal domiciliar per capita */
V4745	820	/*Nível de instrução mais elevado alcançado*/
V4746	821	/*Situação de ocupação na semana de referência das pessoas de 5 anos ou mais de idade*/
V4747	822	/*Atividade principal do empreendimento do trabalho principal */
V4748	823	/*Atividade principal do empreendimento do trabalho principal do período de referência de 365 dias*/
V4749	824	/*Situação de ocupação no período de referência de 365 dias das pessoas de 5 anos ou mais de idade*/
V4750	825-836	/*Rendimento mensal familiar per capita */
V38011	837-838	/*Primeiro responsável pela criança no domicílio*/
V38012	839-840	/*Segundo responsável pela criança no domicílio*/
V3802	841	/*Nos últimos três meses normalmente, de segunda à sexta, onde a criança fica no período da manhã*/
V3803	842	/*Qual o principal motivo para a criança ficar neste local*/
V3804	843	/*A criança fica o período da tarde neste mesmo local e com a mesma pessoa?*/
V3805	844	/*Nos últimos três meses normalmente, de segunda à sexta, onde a criança fica no período da tarde*/
V3806	845	/*Qual o principal motivo para a criança ficar neste local*/
V3807	846	/*Tem interesse em matricular a criança em creche ou escola*/
V3808	847	/*Qual a principal ação que o responsável pela criança tomou para obter uma vaga em creche ou escola*/
V3809	848	/*Informante desta parte*/
V37001	849	/*Marca de seleção de pessoa para o Suplemento de Aspectos das Relações de Trabalho*/
V37002	850	/*Tipo de entrevista*/
V3701	851	/*Foi contratado por intermediário no trabalho único ou principal da semana de referência*/
V3702	852	/*Foi contratado por */
V3703	853	/*Grau de satisfação quanto às condições prometidas e encontradas efetivamente*/
V3704	854	/*Número de horas efetivamente trabalhadas estava*/
V3705	855	/*Sobre a alteração do número de horas trabalhadas em relação ao que tinha sido acordado*/
V3706	856	/*Rendimento efetivamente recebido no trabalho da semana de referência estava*/
V37071	857	/*Possuía débito financeiro de aluguel que o impedia de sair do trabalho que tinha na semana de referência*/
V37072	858	/*Possuía débito financeiro de alimentação que o impedia de sair do trabalho que tinha na semana de referência*/
V37073	859	/*Possuía débito financeiro de instrumentos de trabalho que o impedia de sair do trabalho que tinha na semana de referência*/
V37074	860	/*Possuía débito financeiro de transporte que o impedia de sair do trabalho que tinha na semana de referência*/
V37075	861	/*Possuía outro débito financeiro que o impedia de sair do trabalho que tinha na semana de referência*/
V37091	862	/*Grau de satisfação quanto ao salário e complementos/gratificações salariais*/
V37092	863	/*Grau de satisfação quanto ao valor do auxílio alimentação*/
V37093	864	/*Grau de satisfação quanto à jornada de trabalho*/
V37094	865	/*Grau de satisfação quanto à flexibilidade de horário*/
V37095	866	/*Grau de satisfação quanto ao processo de capacitação profissional*/
V37096	867	/*Grau de satisfação quanto à promoção de igualdade de oportunidades e de tratamento no trabalho*/
V37097	868	/*Grau de satisfação quanto à salubridade e à segurança no ambiente de trabalho*/
V37098	869	/*Grau de satisfação quanto aos benefícios sociais complementares*/
V3719	870-874	/*Peso do morador selecionado para o Suplemento de Aspectos das relações de trabalho SEM ajuste pela projeção de população*/
V3720	875-879	/*Peso do morador selecionado para o Suplemento de Aspectos das relações de trabalho COM ajuste pela projeção de população - usado no cálculo de indicadores de morador selecionado*/
V36001	880	/*Marca de seleção de pessoa para o Suplemento de Práticas de Esporte e Atividade Física*/
V36002	881	/*Tipo de entrevista*/
V3601 	882	/*No período de referência de 365 dias, praticou algum esporte no tempo livre (fora do horário de trabalho e de educação física na escola)*/
V3602 	883	/*Por que motivo praticou esporte no período de referência de 365 dias */
V3603 	884	/*Frequência com que costumava praticar esporte no período de referência de 365 dias*/
V3604 	885-886	/*Número de meses em que praticou esporte com essa frequência*/
V3605 	887	/*Em dia que costumava praticar esporte, o tempo que normalmente dedicava era de*/
V3606 	888	/*No período de referência de 365 dias, praticou mais de uma modalidade de esporte*/
V3607 	889-893	/*Código do principal esporte que praticou no período de referência de 365 dias*/
V3608 	894	/*Costumava praticar esse esporte em*/
V3609 	895	/*Nesse período, praticou esse principal esporte com orientação de professor ou instrutor*/
V3610 	896	/*Nesse período, praticou esse principal esporte como representante ou filiado a alguma instituição*/
V3611 	897	/*Essa instituição era*/
V3612 	898	/*Nesse período, participou de alguma competição desse principal esporte */
V3613 	899	/*O nível dessa competição foi*/
V3614 	900	/*No período de 365 dias, além de todas as atividades de esporte, praticou alguma outra que considerava como atividade física no seu tempo livre (fora do horário de trabalho e da educação física na escola)*/
V3615 	901	/*Por que motivo não praticou esporte no período de referência de 365 dias */
V3616 	902	/*Já praticou algum esporte antes de 27 de setembro de 2014*/
V3617 	903-907	/*Código do último esporte que praticou anteriormente*/
V3618 	908-909	/*Idade com que deixou de praticar esporte*/
V3619 	910	/*Por que motivo parou de praticar esporte*/
V3620 	911	/*No período de referência de 365 dias, praticou alguma atividade física que não considera esporte, no seu tempo livre (fora do horário de trabalho ou da educação física na escola)*/
V3621 	912	/*Por que motivo praticou atividade física no período de referência de 365 dias */
V3622 	913	/*Frequência com que costumava praticar atividade física no período de referência de 365 dias*/
V3623 	914-915	/*Número de meses em que praticou atividade física com essa frequência*/
V3624 	916	/*Em dia que costumava praticar atividade física, o tempo que normalmente dedicava era de*/
V3625 	917-921	/*Código da atividade física que praticou nesse período*/
V3626 	922	/*Costumava praticar essa atividade física em*/
V3627 	923	/*Nesse período, praticou essa principal atividade física com orientação de professor ou instrutor*/
V3628 	924	/*Nesse período, praticou essa principal atividade física como representante ou filiado a alguma instituição*/
V3629 	925	/*Essa instituição era*/
V3630 	926	/*Nesse período, participou de alguma competição dessa principal atividade física*/
V3631 	927	/*O nível dessa competição foi*/
V3632 	928	/*Em sua opinião, o poder público deveria investir no desenvolvimento de atividades físicas ou esportivas na vizinhança em que reside*/
V3633 	929	/*Em sua opinião, em que o poder público deveria investir primeiramente na vizinhança em que reside*/
V3634 	930	/*Esse investimento, na vizinhança em que reside, deveria ser primeiramente*/
V3637 	931-935	/*Peso do morador selecionado para o Suplemento de Práticas de Esporte e Atividade Física SEM ajuste pela projeção de população*/
V3638 	936-940	/*Peso do morador selecionado para o Suplemento de Práticas de Esporte e Atividade Física COM ajuste pela projeção de população - usado no cálculo de indicadores de morador selecionado*/
V9993 	941-948	/*data de geração do arquivo de microdados*/

using "C:\Users\kenia\OneDrive\PNAD_2015\2015\Dados\PES2015.txt";
save "C:\Users\kenia\OneDrive\1. Artigos\Discrimination\2015", replace;
