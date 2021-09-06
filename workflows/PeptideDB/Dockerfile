FROM mcr.microsoft.com/dotnet/sdk:5.0

# Install tool in $HOME/.dotnet/tools
RUN dotnet tool install --global ProteomIQon.PeptideDB --version 0.0.7
# Add tools to PATH
ENV PATH="${PATH}:/root/.dotnet/tools"
# Default Docker starting command
ENTRYPOINT ["proteomiqon-peptidedb"]
CMD ["--help"]