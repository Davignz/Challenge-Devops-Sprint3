# Roteiro de Vídeo (mín. 720p, com áudio claro)

1) **Abertura (10–20s)**
- Diga o nome do grupo e RMs.
- Mostre o PDF com os requisitos (itens principais).

2) **Clone do repositório**
- `git clone <URL_DO_SEU_REPO>` e `cd` no diretório.
- Abra o `README.md` e diga: “seguirei exatamente estes passos”.

3) **Criação de recursos**
- Terminal: `./scripts/create-acr.sh` (mostre o loginServer).
- Terminal: `./scripts/create-mysql.sh` (mostre o FQDN do MySQL).
- Comente rapidamente que o MySQL é PaaS (serviço gerenciado).

4) **Build & Push**
- Ajuste o `Dockerfile` se necessário (mostre a linha do `COPY *.csproj`).
- Rode `./scripts/build-and-push.sh`.
- Mostre a imagem no ACR (portal ou `az acr repository list -n $ACR_NAME`).

5) **Deploy no ACI**
- `./scripts/deploy-aci.sh` e capture o IP público exibido.
- No navegador: `http://<IP>:${APP_PORT}` e comente que o container roda **não-root**.

6) **CRUD direto no MySQL (item 4.2)**
- Abra o cliente `mysql` (ou `MySQL Workbench`) conectado ao FQDN.
- Execute na tela:
  - INSERT → `SELECT` para mostrar o registro.
  - UPDATE → `SELECT` para mostrar a alteração.
  - DELETE → `SELECT` para mostrar que foi removido.
- Faça também uma **consulta de registros** com `ORDER BY`.

7) **Integração App ↔ Banco**
- (Se sua app tem página/listagem) Force uma ação na aplicação que leia/escreva no MySQL.
- Mostre que os dados aparecem/alteram no banco.

8) **Encerramento**
- Mostre rapidamente os scripts utilizados no repositório.
- Reforce o atendimento aos requisitos: ACR + ACI, imagem oficial, sem root, CRUD 100%, README com passo a passo.
- Agradeça e finalize.
