#!/bin/bash
SCARB_NAME="starknetmeetup"
SMART_CONTRACT_NAME="ZkMeetupEvent"
TARGET_PATH="./target/dev"
TS_OUTPUT_PATH="../lib/contract"

SC_PATH="${TARGET_PATH}/${SCARB_NAME}_${SMART_CONTRACT_NAME}"
SIERRA_PATH="${SC_PATH}.contract_class.json"
CASM_PATH="${SC_PATH}.compiled_contract_class.json"

scarb build

echo -e "export const SC_SIERRA = " > "${TS_OUTPUT_PATH}/sierra.ts"
sed 's/`/\\`/g' "${SIERRA_PATH}" >> "${TS_OUTPUT_PATH}/sierra.ts"
echo -e ";" >> "${TS_OUTPUT_PATH}/sierra.ts"

echo -e "export const SC_CASM = " > "${TS_OUTPUT_PATH}/casm.ts"
sed 's/`/\\`/g' "${CASM_PATH}" >> "${TS_OUTPUT_PATH}/casm.ts"
echo -e ";" >> "${TS_OUTPUT_PATH}/casm.ts"

echo -e "\nBuilt SC files successfully."
echo -e "SIERRA: ${SIERRA_PATH}, ${TS_OUTPUT_PATH}/sierra.ts"
echo -e "CASM: ${CASM_PATH}, ${TS_OUTPUT_PATH}/casm.ts"
