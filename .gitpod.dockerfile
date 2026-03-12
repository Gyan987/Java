FROM gitpod/workspace-java-21:2025-11-14-10-05-32

USER root

ARG LLVM_MAJOR=18
ENV LLVM_SCRIPT=/tmp/llvm.sh

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends ca-certificates curl gnupg; \
  rm -rf /var/lib/apt/lists/*; \
  curl -fsSL https://apt.llvm.org/llvm.sh -o "${LLVM_SCRIPT}"; \
  chmod +x "${LLVM_SCRIPT}"; \
  "${LLVM_SCRIPT}" "${LLVM_MAJOR}"; \
  apt-get update; \
  apt-get install -y --no-install-recommends "clang-format-${LLVM_MAJOR}"; \
  rm -rf /var/lib/apt/lists/*; \
  ln -sf "$(command -v clang-format-${LLVM_MAJOR})" /usr/bin/clang-format; \
  rm -f "${LLVM_SCRIPT}"

USER gitpod
