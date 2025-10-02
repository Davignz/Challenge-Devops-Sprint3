# ========= RUNTIME =========
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS base
WORKDIR /app
EXPOSE 8080
# usuário não-root
RUN adduser -u 10001 -D appuser
USER appuser
ENV ASPNETCORE_URLS=http://+:8080

# ========= BUILD =========
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build
WORKDIR /src

# Copie SOMENTE o csproj e restaure (melhor cache)
COPY Sprint-4/Sprint-4.csproj Sprint-4/
RUN dotnet restore "Sprint-4/Sprint-4.csproj"

# Agora copie o resto do código
COPY . .
RUN dotnet build "Sprint-4/Sprint-4.csproj" -c Release -o /app/build

# ========= PUBLISH =========
FROM build AS publish
RUN dotnet publish "Sprint-4/Sprint-4.csproj" -c Release -o /app/publish /p:UseAppHost=false

# ========= FINAL =========
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Sprint-4.dll"]