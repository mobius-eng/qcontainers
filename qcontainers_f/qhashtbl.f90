!===========================================
!
!===========================================
module qhashtbl_util_m
    use iso_c_binding
    use qlibc_util_m
    implicit none

    interface
        type(c_ptr) function qhashtbl_getobj_c() bind(c)
            use iso_c_binding, only: c_ptr
        end function

        subroutine qhashtbl_objinit_c(obj) bind(c)
            use iso_c_binding, only: c_ptr
            type(c_ptr), value :: obj
        end subroutine

        subroutine qhashtbl_getdata_c(obj, val_data) bind(c)
            use iso_c_binding, only: c_ptr
            type(c_ptr), value :: obj
            include "nocheck_val_data.fi"
            real, dimension(*) :: val_data
        end subroutine

        subroutine qhashtbl_getname_c(obj, name) bind(c)
            use iso_c_binding, only: c_ptr
            type(c_ptr), value :: obj
            include "nocheck_name.fi"
            real, dimension(*) :: name
        end subroutine

        integer(c_size_t) function qhashtbl_getnamesize_c(obj) bind(c)
            use iso_c_binding, only: c_ptr, c_size_t
            type(c_ptr), value :: obj
        end function
    end interface

    interface
        !void qhashtbl_copy_c(qhashtbl_t **to, qhashtbl_t *from)
        subroutine qhashtbl_copy_c(to, from) bind(c)
            use iso_c_binding, only: c_ptr
            type(c_ptr) :: to
            type(c_ptr), value :: from
        end subroutine
    end interface
end module qhashtbl_util_m

!===========================================
!
!===========================================
module qhashtbl_interface_m
    implicit none
    !*******************************************
    ! Interfaces for functions in qlist.h
    !*******************************************
    !

    interface
        !qhashtbl_t *qhashtbl(size_t range, int options);
        function qhashtbl_c(range, options) bind(c,name="qhashtbl")
            use iso_c_binding, only: c_ptr, c_size_t, c_int
            type(c_ptr) :: qhashtbl_c
            integer(c_size_t), value :: range
            integer(c_int), value :: options
        end function

        !bool qhashtbl_put(qhashtbl_t *tbl, const char *name, const void *data, size_t size);
        function qhashtbl_put_c(tbl, name, val_data, size) bind(c,name="qhashtbl_put")
            use iso_c_binding, only: c_bool, c_ptr, c_char, c_size_t
            logical(c_bool) :: qhashtbl_put_c
            type(c_ptr), value :: tbl
            character(kind=c_char), dimension(*) :: name
            include "nocheck_val_data.fi"
            real, dimension(*)       :: val_data
            integer(c_size_t), value :: size
        end function

!        !bool qhashtbl_putstr(qhashtbl_t *tbl, const char *name, const char *str);
!        function qhashtbl_putstr(tbl, name, str) bind(c)
!            use iso_c_binding, only: c_bool, c_ptr, c_char
!            logical(c_bool) :: qhashtbl_putstr
!            type(c_ptr), value :: tbl
!            character(kind=c_char), dimension(*) :: name
!            character(kind=c_char), dimension(*) :: str
!        end function

!        !bool qhashtbl_putint(qhashtbl_t *tbl, const char *name, int64_t num);
!        function qhashtbl_putint(tbl, name, num) bind(c)
!            use iso_c_binding, only: c_bool, c_ptr, c_char
!            logical(c_bool) :: qhashtbl_putint
!            type(c_ptr), value :: tbl
!            character(kind=c_char), dimension(*) :: name
!            integer(int64_t), value :: num
!        end function

        !void *qhashtbl_get(qhashtbl_t *tbl, const char *name, size_t *size, bool newmem);
        function qhashtbl_get_c(tbl, name, size, newmem) bind(c,name="qhashtbl_get")
            use iso_c_binding, only: c_ptr, c_char, c_bool
            type(c_ptr) :: qhashtbl_get_c
            type(c_ptr), value :: tbl
            character(kind=c_char), dimension(*) :: name
            type(c_ptr), value :: size
            logical(c_bool), value :: newmem
        end function

!        !char *qhashtbl_getstr(qhashtbl_t *tbl, const char *name, bool newmem);
!        function qhashtbl_getstr(tbl, name, newmem) bind(c)
!            use iso_c_binding, only: c_ptr, c_char, c_bool
!            type(c_ptr) :: qhashtbl_getstr
!            type(c_ptr), value :: tbl
!            character(kind=c_char), dimension(*) :: name
!            logical(c_bool), value :: newmem
!        end function

!        !int64_t qhashtbl_getint(qhashtbl_t *tbl, const char *name);
!        function qhashtbl_getint(tbl, name) bind(c)
!            use iso_c_binding, only: int64_t, c_ptr, c_char
!            integer(int64_t) :: qhashtbl_getint
!            type(c_ptr), value :: tbl
!            character(kind=c_char), dimension(*) :: name
!        end function

        !bool qhashtbl_remove(qhashtbl_t *tbl, const char *name);
        function qhashtbl_remove_c(tbl, name) bind(c,name="qhashtbl_remove")
            use iso_c_binding, only: c_bool, c_ptr, c_char
            logical(c_bool) :: qhashtbl_remove_c
            type(c_ptr), value :: tbl
            character(kind=c_char), dimension(*) :: name
        end function

        !bool qhashtbl_getnext(qhashtbl_t *tbl, qhashtbl_obj_t *obj, bool newmem);
        function qhashtbl_getnext_c(tbl, obj, newmem) bind(c,name="qhashtbl_getnext")
            use iso_c_binding, only: c_bool, c_ptr
            logical(c_bool) :: qhashtbl_getnext_c
            type(c_ptr), value :: tbl
            type(c_ptr), value :: obj
            logical(c_bool), value :: newmem
        end function

        !size_t qhashtbl_size(qhashtbl_t *tbl);
        function qhashtbl_size_c(tbl) bind(c,name="qhashtbl_size")
            use iso_c_binding, only: c_size_t, c_ptr
            integer(c_size_t) :: qhashtbl_size_c
            type(c_ptr), value :: tbl
        end function

        !void qhashtbl_clear(qhashtbl_t *tbl);
        subroutine qhashtbl_clear_c(tbl) bind(c,name="qhashtbl_clear")
            use iso_c_binding, only: c_ptr
            type(c_ptr), value :: tbl
        end subroutine

!        !bool qhashtbl_debug(qhashtbl_t *tbl, FILE *out);
!        function qhashtbl_debug(tbl, out) bind(c)
!            use iso_c_binding, only: c_bool, c_ptr
!            logical(c_bool) :: qhashtbl_debug
!            type(c_ptr), value :: tbl
!            type(c_ptr), value :: out
!        end function

!        !void qhashtbl_lock(qhashtbl_t *tbl);
!        subroutine qhashtbl_lock(tbl) bind(c)
!            use iso_c_binding, only: c_ptr
!            type(c_ptr), value :: tbl
!        end subroutine
!
!        !void qhashtbl_unlock(qhashtbl_t *tbl);
!        subroutine qhashtbl_unlock(tbl) bind(c)
!            use iso_c_binding, only: c_ptr
!            type(c_ptr), value :: tbl
!        end subroutine

        !void qhashtbl_free(qhashtbl_t *tbl);
        subroutine qhashtbl_free_c(tbl) bind(c, name="qhashtbl_free")
            use iso_c_binding, only: c_ptr
            type(c_ptr), value :: tbl
        end subroutine

    end interface
end module qhashtbl_interface_m

!===========================================
!
!===========================================
module qhashtbl_m
    use iso_c_binding
    use qhashtbl_interface_m
    use qlibc_util_m
    use qhashtbl_util_m
    implicit none


    type, public :: qhashtbl_t
        private
        type(c_ptr) :: q_cp = c_null_ptr
        integer(c_size_t) :: size_data

        logical :: was_init = .false.
        ! It seems, that gfortran has a bug, which prevents qobj to be initialized to c_null_ptr here.
        ! variable wasInit is used as a workaround.
    contains
        final :: qhashtbl_free
        procedure :: new => qhashtbl_new
        procedure :: put => qhashtbl_put
        procedure :: putstr => qhashtbl_putstr
        procedure :: get => qhashtbl_get
        procedure :: getstr => qhashtbl_getstr
        procedure :: haskey => qhashtbl_haskey
        procedure :: remove => qhashtbl_remove
        procedure :: size => qhashtbl_size
        procedure :: getnext => qhashtbl_getnext
        procedure :: clear => qhashtbl_clear
    end type

    ! Type describes a one object of the qhashtbl
    type, public :: qhashtbl_obj_t
        type(c_ptr) :: qobj = c_null_ptr
        logical :: wasInit = .false.
        ! It seems, that gfortran has a bug, which prevents qobj to be initialized to c_null_ptr here.
        ! Variable wasInit is used as a workaround.
    contains
        final :: qhashtbl_objfree
        procedure :: getdata => qhashtbl_getdata                !< Get data from the object.
        procedure :: getname => qhashtbl_getname                !< Get name from the object.
        procedure :: init => qhashtbl_objinit                   !< Initialize the object.
    end type

    interface assignment(=)
        module procedure qhashtbl_copy
        module procedure qhashtbl_obj_copy
    end interface

    private
    public :: assignment(=)

contains

    !> @brief qhashtbl constructor
    !!
    subroutine qhashtbl_new(self, range, size_data)
        class(qhashtbl_t) :: self
        integer, optional, intent(in) :: range      !< initial size of index range. Value of 0 will use default value.
        integer, optional, intent(in) :: size_data  !< size of each element in bytes.

        integer(c_int) :: opt = 0
        integer(c_size_t) :: ran

        if (present(range)) then
            ran = range
        else
            ran = 0
        end if
        self%q_cp = qhashtbl_c(ran, opt)
        if (present(size_data)) then
            self%size_data = int(size_data, kind=c_size_t)
        else
            self%size_data = 0
        end if

        self%was_init = .true.
    end subroutine

    !> @brief  Destructor of the qhashtbl.
    !!
    subroutine qhashtbl_free(self)
        type(qhashtbl_t), intent(inout) :: self

        if (.not. self%was_init) then
            self%q_cp = c_null_ptr
            self%was_init = .true.
        end if

        if (c_associated(self%q_cp)) then
            call qhashtbl_free_c(self%q_cp)
            self%q_cp = c_null_ptr
        end if
    end subroutine

    !> @brief  Put a value into this table.
    !!
    subroutine qhashtbl_put(self, name, val_data, size_data, success)
        class(qhashtbl_t), intent(inout) :: self
        character(len=*), intent(in) :: name       !< key name.
        include "nocheck_val_data.fi"
        real, dimension(*), intent(in) :: val_data             !< data to put.
        integer, optional, intent(in)  :: size_data !< size of data object.
        logical, optional, intent(out) :: success  !< true if successful.

        integer(c_size_t) :: sd
        logical(c_bool) :: suc_c

        if (present(size_data)) then
            sd = int(size_data, kind=c_size_t)
        else
            sd = self%size_data
        end if

        suc_c = qhashtbl_put_c(self%q_cp, f_c_string(name), val_data, sd)
        if (present(success)) success = suc_c
    end subroutine

    !> @brief  Put a string into this table.
    !!
    subroutine qhashtbl_putstr(self, name, str_data, success)
        class(qhashtbl_t), intent(inout) :: self
        character(len=*), intent(in)     :: name      !< key name.
        character(len=*), intent(in)     :: str_data  !< string to put.
        logical, optional, intent(out)   :: success   !< true if successful.

        logical(c_bool) :: suc_c

        suc_c = qhashtbl_put_c(self%q_cp, f_c_string(name), str_data, len(str_data, kind=c_size_t))
        if (present(success)) success = suc_c
    end subroutine

    !> @brief Get data from the table.
    !!
    subroutine qhashtbl_get(self, name, val_data, found)
        class(qhashtbl_t), intent(in) :: self
        character(len=*), intent(in)  :: name  !< key name.
        include "nocheck_val_data.fi"
        real, dimension(*)   :: val_data       !< returned data.
        logical, intent(out) :: found          !< true if key was found.

        integer(c_size_t), target :: size_data
        type(c_ptr) :: size_data_p
        type(c_ptr) :: val_data_p
        logical(c_bool) :: newmem = .false.

        size_data_p = c_loc(size_data)
        val_data_p = qhashtbl_get_c(self%q_cp, f_c_string(name), size_data_p, newmem)
        if (c_associated(val_data_p)) then
            call qlibc_copy_data_c(val_data_p, val_data, size_data, newmem)
            found = .true.
        else
            found = .false.
        end if
    end subroutine

    !> @brief Get character data.
    !!
    subroutine qhashtbl_getstr(self, name, str_data, found)
        class(qhashtbl_t), intent(in) :: self
        character(len=*), intent(in)  :: name  !< key name.
        character(len=:), allocatable, intent(inout) :: str_data  !< returned string.
        logical, intent(out) :: found          !< true if key was found, else false.

        integer(c_size_t), target :: size_data
        type(c_ptr) :: size_data_p
        type(c_ptr) :: val_data_p
        logical(c_bool) :: newmem = .false.

        size_data_p = c_loc(size_data)
        val_data_p = qhashtbl_get_c(self%q_cp, f_c_string(name), size_data_p, newmem)
        if (c_associated(val_data_p)) then
            if (allocated(str_data)) then
                if (len(str_data) /= size_data) then
                    deallocate(str_data)
                    allocate(character(len=size_data) :: str_data)
                end if
            else
                allocate(character(len=size_data) :: str_data)
            end if
            call qlibc_copy_data_c(val_data_p, str_data, size_data, newmem)
            found = .true.
        else
            found = .false.
        end if
    end subroutine

    !> @brief Return if the key is in the container.
    !!
    logical function qhashtbl_haskey(self, name)
        class(qhashtbl_t), intent(in) :: self
        character(len=*), intent(in)  :: name  !< key name.

        type(c_ptr) :: size_data_p
        type(c_ptr) :: val_data_p
        logical(c_bool) :: newmem = .false.

        size_data_p = c_null_ptr
        val_data_p = qhashtbl_get_c(self%q_cp, f_c_string(name), size_data_p, newmem)
        if (c_associated(val_data_p)) then
            qhashtbl_haskey = .true.
        else
            qhashtbl_haskey = .false.
        end if
    end function

    !> @brief Remove an object from this table.
    !!
    subroutine qhashtbl_remove(self, name, success)
        class(qhashtbl_t), intent(inout) :: self
        character(len=*), intent(in)  :: name     !< key name.
        logical, optional, intent(out) :: success !< true if successful, else false.

        logical(c_bool) :: suc

        suc = qhashtbl_remove_c(self%q_cp, f_c_string(name))
        if (present(success)) success = suc
    end subroutine

    !> @brief Get next element.
    !!
    logical function qhashtbl_getnext(self, obj)
        class(qhashtbl_t), intent(in) :: self
        type(qhashtbl_obj_t), intent(inout) :: obj  !< qhashtbl object.
        logical(c_bool) :: newmem = .false.

        qhashtbl_getnext = qhashtbl_getnext_c(self%q_cp, obj%qobj, newmem)
    end function

    !> @brief Returns the number of keys in this hashtable.
    !!
    integer function qhashtbl_size(self)
        class(qhashtbl_t), intent(in) :: self

        qhashtbl_size = qhashtbl_size_c(self%q_cp)
    end function

    !> @brief Clears this hashtable so that it contains no keys.
    !!
    subroutine qhashtbl_clear(self)
        class(qhashtbl_t), intent(inout) :: self

        call qhashtbl_clear_c(self%q_cp)
    end subroutine

    !> @brief Copy procedure.
    !!
    subroutine qhashtbl_copy(to, from)
        type(qhashtbl_t), intent(inout) :: to
        type(qhashtbl_t), intent(in)    :: from

        if (.not. to%was_init) then
            to%q_cp = c_null_ptr
            to%was_init = .true.
        end if
        call qhashtbl_copy_c(to%q_cp, from%q_cp)
        to%size_data = from%size_data
    end subroutine



    !**********************************************
    !*** Procedures for work with qhashtbl_obj_t
    !**********************************************

    !> @brief Initialize the object. Should be called before the use of the object.
    !!
    subroutine qhashtbl_objinit(obj)
        class(qhashtbl_obj_t), intent(inout) :: obj

        if (.not. obj%wasInit) then
            obj%wasInit = .true.
            obj%qobj = c_null_ptr
        end if

        if ( .not. c_associated(obj%qobj)) then
            obj%qobj = qhashtbl_getobj_c()
        else
            call qhashtbl_objinit_c(obj%qobj)
        end if
    end subroutine

    !> @brief Destructor.
    !!
    subroutine qhashtbl_objfree(obj)
        type(qhashtbl_obj_t), intent(inout) :: obj

        if (.not. obj%wasInit) then
            obj%qobj = c_null_ptr
            obj%wasInit = .true.
        end if
        if (c_associated(obj%qobj)) then
            call qlibc_free_c(obj%qobj)
            obj%qobj = c_null_ptr
        end if
    end subroutine

    !> @brief Copy procedure. Should not be called.
    !!
    subroutine qhashtbl_obj_copy(to, from)
        type(qhashtbl_obj_t), intent(inout) :: to
        type(qhashtbl_obj_t), intent(in)    :: from

        print *, "Error. qhashtbl_obj_t object can not be copied."
        print *, "Sub: qhashtbl_obj_copy"
        stop "Program terminated!"
    end subroutine

    !> @brief Get data from the object.
    !!
    subroutine qhashtbl_getdata(obj, val_data)
        class(qhashtbl_obj_t) :: obj
        include "nocheck_val_data.fi"
        real, dimension(*) :: val_data   !< returned data.

        call qhashtbl_getdata_c(obj%qobj, val_data)
    end subroutine

    !> @brief Get name from the object.
    !!
    subroutine qhashtbl_getname(obj, name)
        class(qhashtbl_obj_t) :: obj
        character(len=:), allocatable, intent(inout) :: name  !< returned name

        integer(c_size_t) :: namesize

        namesize = qhashtbl_getnamesize_c(obj%qobj)
        if (allocated(name)) then
            if (len(name) /= namesize) then
                deallocate(name)
                allocate(character(len=namesize) :: name)
            end if
        else
            allocate(character(len=namesize) :: name)
        end if

        call qhashtbl_getname_c(obj%qobj, name)
    end subroutine

end module

