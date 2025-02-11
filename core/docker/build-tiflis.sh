TRINO_VERSION=$(./mvnw -f ./pom.xml --quiet help:evaluate -Dexpression=project.version -DforceStdout)
echo "🎯 Using currently built artifacts from the core/trino-server and client/trino-cli modules and version ${TRINO_VERSION}"
trino_server="./core/trino-server/target/trino-server-${TRINO_VERSION}.tar.gz"
trino_client="./client/trino-cli/target/trino-cli-${TRINO_VERSION}-executable.jar"

echo "🧱 Preparing the image build context directory"
WORK_DIR="publish"
mkdir -p "${WORK_DIR}"
cp "$trino_server" "${WORK_DIR}/"
cp "$trino_client" "${WORK_DIR}/"
tar -C "${WORK_DIR}" -xzf "${WORK_DIR}/trino-server-${TRINO_VERSION}.tar.gz"
rm "${WORK_DIR}/trino-server-${TRINO_VERSION}.tar.gz"
cp -R core/docker/bin "${WORK_DIR}/trino-server-${TRINO_VERSION}"
cp -R core/docker/default "${WORK_DIR}/"