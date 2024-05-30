#!/bin/bash
mkdir -p /tmp
/bin/local-cluster  --working-dir /tmp/cluster \
                    --wallet-dir /tmp/wallets/ \
                    --num-wallets ${PLUTIP_NUM_WALLETS:-3} \
                    --ada ${PLUTIP_ADA:-10000} \
                    --lovelace ${PLUTIP_LOVELACE:-0} \
                    --utxos ${PLUTIP_NUM_UTXOS:-1} \
                    --slot-len ${PLUTIP_SLOT_LENGTH:-1.0s} \
                    --epoch-size ${PLUTIP_EPOCH_SIZE:-10}

