#!/bin/bash
# SessionStart hook: устанавливает OneScript (oscript/opm) и зависимости проекта,
# чтобы тесты и проверка синтаксиса работали в сессиях Claude Code on the web.
#
# OneScript ставится в /opt/oscript (состояние контейнера кешируется после
# завершения хука), а путь к бинарникам добавляется в PATH через $CLAUDE_ENV_FILE,
# поэтому oscript остаётся доступен во всех последующих сессиях.
set -euo pipefail

# Запускаемся только в удалённом окружении (Claude Code on the web).
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Версия OneScript. Должна удовлетворять .ВерсияСреды из packagedef (>= 1.9.2).
# 2.0.1 — self-contained сборка для linux-x64, не требует Mono/.NET.
OSCRIPT_VERSION="2.0.1"
OSCRIPT_HOME="/opt/oscript"
OSCRIPT_BIN="${OSCRIPT_HOME}/bin"
OSCRIPT_URL="https://github.com/EvilBeaver/OneScript/releases/download/v${OSCRIPT_VERSION}/OneScript-${OSCRIPT_VERSION}-linux-x64.zip"

# Имена файлов внутри архива содержат кириллицу; без UTF-8 локали unzip их ломает.
export LC_ALL=C.UTF-8

# Устанавливаем OneScript, если ещё не установлен нужной версии (идемпотентно).
if [ -x "${OSCRIPT_BIN}/oscript" ] && [ "$("${OSCRIPT_BIN}/oscript" -version 2>/dev/null)" = "${OSCRIPT_VERSION}" ]; then
  echo "OneScript ${OSCRIPT_VERSION} уже установлен в ${OSCRIPT_HOME}"
else
  echo "Устанавливаю OneScript ${OSCRIPT_VERSION}..."
  tmp_zip="$(mktemp --suffix=.zip)"
  curl -fsSL -o "${tmp_zip}" "${OSCRIPT_URL}"
  rm -rf "${OSCRIPT_HOME}"
  mkdir -p "${OSCRIPT_HOME}"
  unzip -q "${tmp_zip}" -d "${OSCRIPT_HOME}"
  rm -f "${tmp_zip}"
  chmod +x "${OSCRIPT_BIN}/oscript" "${OSCRIPT_BIN}/opm"
  echo "OneScript $("${OSCRIPT_BIN}/oscript" -version) установлен в ${OSCRIPT_HOME}"
fi

# Делаем oscript/opm доступными в текущем и последующих сессиях.
export PATH="${OSCRIPT_BIN}:${PATH}"
if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  echo "export PATH=\"${OSCRIPT_BIN}:\$PATH\"" >> "${CLAUDE_ENV_FILE}"
  echo "export LC_ALL=C.UTF-8" >> "${CLAUDE_ENV_FILE}"
fi

# Устанавливаем зависимости проекта (включая dev) в ./oscript_modules.
# opm install идемпотентен: уже установленные пакеты пропускаются.
cd "${CLAUDE_PROJECT_DIR}"
echo "Устанавливаю зависимости проекта (opm install -l --dev)..."
opm install -l --dev

echo "Окружение OneScript готово."
