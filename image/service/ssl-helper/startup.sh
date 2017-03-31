#!/bin/bash -e
log-helper level eq trace && set -x

for prefix in ${SSL_HELPER_PREFIX_TO_GENERATE[@]}
do
  prefix=${prefix^^}
  log-helper info "Process prefix ${prefix}..."

  PREFIX_CERT_FILE=${prefix}_SSL_HELPER_CERT_FILE
  PREFIX_KEY_FILE=${prefix}_SSL_HELPER_KEY_FILE
  PREFIX_CA_FILE=${prefix}_SSL_HELPER_CA_FILE

  PREFIX_DHPARAM_FILE=${prefix}_SSL_HELPER_DHPARAM_FILE
  PREFIX_DHPARAM_NUMBITS=${prefix}_SSL_HELPER_DHPARAM_NUMBITS

  CERT_FILE=${!PREFIX_CERT_FILE}
  KEY_FILE=${!PREFIX_KEY_FILE}
  CA_FILE=${!PREFIX_CA_FILE}

  DHPARAM_FILE=${!PREFIX_DHPARAM_FILE}
  DHPARAM_NUMBITS=${!PREFIX_DHPARAM_NUMBITS:-2048}


  log-helper debug "cert: ${CERT_FILE}"
  log-helper debug "key: ${KEY_FILE}"
  log-helper debug "ca: ${CA_FILE}"

  log-helper debug "dhparam: ${DHPARAM_FILE}"
  log-helper debug "dhparam numbits: ${DHPARAM_NUMBITS}"


  if [ -z "$CERT_FILE" ] || [ -z "$KEY_FILE" ] || [ -z "$CA_FILE" ]; then
    log-helper info "${PREFIX_CERT_FILE}, ${PREFIX_KEY_FILE} or ${PREFIX_CA_FILE} not set:"
    log-helper info "ssl-helper will not run."
  else
      ssl-helper ${prefix} ${CERT_FILE} ${KEY_FILE} ${CA_FILE}
  fi

  if [ -n "${DHPARAM_FILE}" ]; then
    log-helper info "dhparam file set: ${DHPARAM_FILE}"
    if [ ! -f ${DHPARAM_FILE} ]; then
     log-helper info "file don't exists generate (${DHPARAM_NUMBITS} bits)"
     openssl dhparam -out ${DHPARAM_FILE} ${DHPARAM_NUMBITS}
    fi
  fi
done
