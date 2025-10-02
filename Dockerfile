
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS base
WORKDIR /app
EXPOSE 8080

RUN adduser -u 10001 -D appuser
USER appuser
ENV ASPNETCORE_URLS=http://+:8080

FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build
WORKDIR /src

COPY Sprint-4/Sprint-4.csproj Sprint-4/
RUN dotnet restore "Sprint-4/Sprint-4.csproj"

COPY . .
RUN dotnet build "Sprint-4/Sprint-4.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Sprint-4/Sprint-4.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Sprint-4.dll"]