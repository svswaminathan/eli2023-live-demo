FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

ENV ASPNETCORE_URLS=http://+:80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["eli2023-live-demo.csproj", "./"]
RUN dotnet restore "eli2023-live-demo.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "eli2023-live-demo.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "eli2023-live-demo.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "eli2023-live-demo.dll"]
