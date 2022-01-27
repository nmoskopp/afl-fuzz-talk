#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
  FILE *file = fopen(argv[1], "r");

  // the magic value is ASCII !?
  char magic[2];
  magic[0] = fgetc(file);
  assert(33 == magic[0]);

  magic[1] = fgetc(file);
  assert(63 == magic[1]);

  // the third byte is ignored
  char filler = fgetc(file);

  char lengthfield[2];
  lengthfield[0] = fgetc(file);
  lengthfield[1] = fgetc(file);
  int length = atoi(&lengthfield[0]) * 10 + atoi(&lengthfield[1]);

  char separator = fgetc(file);
  if (58 != separator) { // ascii colon (:)
    fclose(file);
    exit(2);
  }

  char *buffer = malloc(length);
  fgets(buffer, length, file);

  fclose(file);

  printf(buffer);
  printf("\n");

  char *buffer_uppercase = malloc(strlen(buffer) + 1);
  for (int i = 0; i < length; i++) {
    // ASCII uppercase hack, just substract 32
    int tmp = buffer[i] - 32;
    if (tmp > 20) { // skip special chars
      buffer_uppercase[i] = tmp;
    }
  }

  printf(buffer_uppercase);
  printf("\n");
}
