using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace BookAPI.Models
{
    public class Category
    {
        //properties
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)] //auto gen. id
        public int Id { get; set; }
        [Required]
        [MaxLength(50, ErrorMessage = "Category must be up to 50 characters in lenght")]
        public string Name { get; set; }

        //representing relations between tables
        public virtual ICollection<BookCategory> BookCategories { get; set; }
    }
}
