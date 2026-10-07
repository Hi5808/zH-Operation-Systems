/*
 * bionic-environ.c - LD_PRELOAD shim for libhybris processes on the
 * Blackview BL6000 Pro (Mali-G57 r25p0, Valhall).
 *
 * The Mali userspace driver imports environ@LIBC (bionic) and refuses to
 * initialise when it is NULL:
 *     ldr x8,[GOT environ]; ldr x8,[x8]; cbz x8 -> error 3
 *     "cdbgp_populate_from_system_environment ...
 *      Initialization of a handle to the system environment failed (3)"
 * libhybris never runs bionic's libc init, so bionic's environ stays NULL.
 * This shim points bionic's environ at the process's real (glibc) environ.
 */
#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdio.h>

extern char **environ;

__attribute__((constructor))
static void bionic_environ_fixup(void)
{
    void *hc = dlopen("libhybris-common.so.1", RTLD_NOW | RTLD_GLOBAL);
    if (!hc)
        return;
    void *(*a_dlopen)(const char *, int) = dlsym(hc, "android_dlopen");
    void *(*a_dlsym)(void *, const char *) = dlsym(hc, "android_dlsym");
    if (!a_dlopen || !a_dlsym)
        return;
    void *libc = a_dlopen("libc.so", RTLD_NOW);
    if (!libc)
        return;
    char ***benv = a_dlsym(libc, "environ");
    if (benv && *benv == NULL)
        *benv = environ;
}
