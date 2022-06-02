set -x

SCRIPT_PATH=`readlink -f "$0"`
SCRIPT_DIR=`dirname "$SCRIPT_PATH"`
cd "$SCRIPT_DIR"

source config.sh
source ../cred/scp_config.sh

scp -i $CRED ../build/$GAME-web.zip $USER@$HOST:$GAMES_PATH

ssh -i $CRED $USER@$HOST << EOF
set -x
cd $GAMES_PATH
rm -rf $GAME-web/
unzip $GAME-web.zip
rm $GAME-web.zip
EOF
